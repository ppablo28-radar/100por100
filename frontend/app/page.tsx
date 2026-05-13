"use client";

import { useEffect, useRef, useState } from "react";
import {
  soundCorrect, soundIncorrect, soundCountdownBeep,
  soundGameStart, soundReveal, soundEpic, soundStreak,
  soundGameOver, initAudio,
} from "./sounds";

type Phase = "SELECT" | "JOIN" | "LOBBY" | "COUNTDOWN" | "QUESTION" | "REVEAL" | "FINISHED";

const PRESET_MODES = [
  { key: "general",    emoji: "🌍", name: "General",   desc: "De todo para todos" },
  { key: "gaming",     emoji: "🎮", name: "Gaming",    desc: "Videojuegos y streamers" },
  { key: "futbol",     emoji: "⚽", name: "Fútbol",    desc: "Solo fútbol" },
  { key: "anime",      emoji: "⛩️", name: "Anime",     desc: "Anime y manga" },
  { key: "ciencia",    emoji: "🔬", name: "Ciencia",   desc: "Datos y curiosidades" },
  { key: "custom",     emoji: "📍", name: "Otro modo", desc: "Escribí el tema" },
] as const;

type QuestionData = {
  question: string;
  options: string[];
  duration: number;
  question_number: number;
  total_questions: number;
};

type QuestionResult = {
  nickname: string;
  correct: boolean | null;
  response_time_ms: number | null;
  points_earned: number;
};

type RevealData = {
  correct: string;
  correct_index: number;
  correct_pct: number;
  question_results: QuestionResult[];
};

type Player = {
  nickname: string;
  score: number;
  correct_count?: number;
  answered_count?: number;
  avg_time_ms?: number;
};

const OPTION_COLORS = [
  "bg-blue-700 hover:bg-blue-600",
  "bg-red-700 hover:bg-red-600",
  "bg-yellow-600 hover:bg-yellow-500",
  "bg-green-700 hover:bg-green-600",
];

const OPTION_COLORS_BASE = [
  "bg-blue-700",
  "bg-red-700",
  "bg-yellow-600",
  "bg-green-700",
];

export default function Home() {
  const ws = useRef<WebSocket | null>(null);
  const timerRef = useRef<ReturnType<typeof setInterval> | null>(null);
  const startTimerRef = useRef<ReturnType<typeof setInterval> | null>(null);
  const countdownStartedRef = useRef(false);
  const scoreboardRef = useRef<Player[]>([]);
  const prevPositionsRef = useRef<Record<string, number>>({});
  const streakRef = useRef(0);
  const lastBeepRef = useRef(0);
  const nicknameRef = useRef("");

  const [nickname, setNickname] = useState("");
  const [phase, setPhase] = useState<Phase>("SELECT");
  const [selectedMode, setSelectedMode] = useState("general");
  const [customMode, setCustomMode] = useState("");
  const [playerCount, setPlayerCount] = useState(0);
  const [countdown, setCountdown] = useState<number | null>(null);
  const [startCountdown, setStartCountdown] = useState<number | null>(null);
  const [question, setQuestion] = useState<QuestionData | null>(null);
  const [selectedAnswer, setSelectedAnswer] = useState<number | null>(null);
  const [timeLeft, setTimeLeft] = useState(0);
  const [revealData, setRevealData] = useState<RevealData | null>(null);
  const [scoreboard, setScoreboard] = useState<Player[]>([]);
  const [connected, setConnected] = useState(false);
  const [modeCounts, setModeCounts] = useState<Record<string, number>>({});
  const [secondaryModes, setSecondaryModes] = useState<{mode: string; count: number}[]>([]);
  const [funMessage, setFunMessage] = useState<string | null>(null);
  const [streakCount, setStreakCount] = useState(0);
  const [answerAnim, setAnswerAnim] = useState<"correct" | "wrong" | null>(null);
  const [floatingPts, setFloatingPts] = useState<number | null>(null);

  // Beep en los últimos 3 segundos de cada pregunta
  useEffect(() => {
    if (phase === "QUESTION" && timeLeft <= 3 && timeLeft > 0) {
      if (lastBeepRef.current !== timeLeft) {
        lastBeepRef.current = timeLeft;
        soundCountdownBeep();
      }
    }
  }, [timeLeft, phase]);

  const beginStartCountdown = (seconds: number) => {
    if (startTimerRef.current) clearInterval(startTimerRef.current);
    countdownStartedRef.current = true;
    setStartCountdown(seconds);
    const endTime = Date.now() + seconds * 1000;
    startTimerRef.current = setInterval(() => {
      const remaining = Math.max(0, Math.ceil((endTime - Date.now()) / 1000));
      setStartCountdown(remaining);
      if (remaining <= 0 && startTimerRef.current) clearInterval(startTimerRef.current);
    }, 500);
  };

  const apiBase = (process.env.NEXT_PUBLIC_WS_URL ?? "ws://127.0.0.1:8000/ws")
    .replace("wss://", "https://")
    .replace("ws://", "http://")
    .replace("/ws", "");

  // Fetch question counts per mode
  useEffect(() => {
    fetch(`${apiBase}/counts`)
      .then((r) => r.json())
      .then(setModeCounts)
      .catch(() => {});
  }, []);

  // Fetch secondary modes when "Personalizado" is selected
  useEffect(() => {
    if (selectedMode !== "custom") return;
    fetch(`${apiBase}/modes`)
      .then((r) => r.json())
      .then(setSecondaryModes)
      .catch(() => {});
  }, [selectedMode]);

  // Preseleccionar modo desde URL (?mode=gaming)
  useEffect(() => {
    if (typeof window === "undefined") return;
    const urlMode = new URLSearchParams(window.location.search).get("mode");
    if (!urlMode) return;
    const isPreset = PRESET_MODES.some(m => m.key === urlMode && m.key !== "custom");
    if (isPreset) {
      setSelectedMode(urlMode);
    } else {
      setSelectedMode("custom");
      setCustomMode(urlMode);
    }
  }, []);

  useEffect(() => {
    const WS_URL = process.env.NEXT_PUBLIC_WS_URL ?? "ws://127.0.0.1:8000/ws";
    const socket = new WebSocket(WS_URL);
    ws.current = socket;

    socket.onopen = () => setConnected(true);
    socket.onclose = () => {
      setConnected(ws.current?.readyState === WebSocket.OPEN);
    };

    socket.onmessage = (event) => {
      const data = JSON.parse(event.data);

      if (data.type === "PING") {
        socket.send(JSON.stringify({ type: "PONG" }));
        return;
      }

      if (data.type === "PLAYER_JOINED") {
        setPlayerCount(data.count);
        if (data.starts_in != null && !countdownStartedRef.current) {
          beginStartCountdown(data.starts_in as number);
        }
      }

      if (data.type === "PLAYER_LEFT") {
        setPlayerCount(data.count);
      }

      if (data.type === "START_CANCELLED") {
        setPlayerCount(data.count);
        if (startTimerRef.current) clearInterval(startTimerRef.current);
        countdownStartedRef.current = false;
        setStartCountdown(null);
      }

      if (data.type === "STARTING_SOON") {
        beginStartCountdown(data.seconds as number);
      }

      if (data.type === "COUNTDOWN") {
        if (startTimerRef.current) clearInterval(startTimerRef.current);
        countdownStartedRef.current = false;
        setStartCountdown(null);
        setPhase("COUNTDOWN");
        setCountdown(data.value);
        if (data.value === 1) soundGameStart();
      }

      if (data.type === "NEW_QUESTION") {
        setPhase("QUESTION");
        setQuestion(data as QuestionData);
        setSelectedAnswer(null);
        setRevealData(null);
        setFunMessage(null);
        setAnswerAnim(null);
        setFloatingPts(null);
        lastBeepRef.current = 0;

        const duration = data.duration as number;
        setTimeLeft(duration);

        if (timerRef.current) clearInterval(timerRef.current);
        const endTime = Date.now() + duration * 1000;
        timerRef.current = setInterval(() => {
          const remaining = Math.max(0, Math.ceil((endTime - Date.now()) / 1000));
          setTimeLeft(remaining);
          if (remaining <= 0 && timerRef.current) clearInterval(timerRef.current);
        }, 200);
      }

      if (data.type === "ANSWER_REVEAL") {
        const reveal = data as RevealData;
        setPhase("REVEAL");
        setRevealData(reveal);
        if (timerRef.current) clearInterval(timerRef.current);
        soundReveal();

        // Determinar si el jugador actual acertó
        const myResult = reveal.question_results?.find(
          (r: QuestionResult) => r.nickname === nicknameRef.current
        );
        const isCorrect = myResult?.correct === true;

        // Sonido y animación según resultado
        setTimeout(() => {
          if (isCorrect) {
            soundCorrect();
            setAnswerAnim("correct");
            setFloatingPts(myResult?.points_earned ?? null);
            streakRef.current += 1;
            setStreakCount(streakRef.current);
          } else {
            soundIncorrect();
            setAnswerAnim("wrong");
            streakRef.current = 0;
            setStreakCount(0);
          }
        }, 300);

        // Racha épica
        if (isCorrect && streakRef.current + 1 >= 3) {
          setTimeout(() => soundStreak(), 600);
        }

        // Momento épico: solo vos acertaste
        const totalPlayers = reveal.question_results?.length ?? 0;
        const correctCount = reveal.question_results?.filter(
          (r: QuestionResult) => r.correct === true
        ).length ?? 0;
        const soloCorrect = isCorrect && correctCount === 1;
        const soloWrong   = !isCorrect && correctCount === totalPlayers - 1 && totalPlayers > 1;

        if (soloCorrect) setTimeout(() => soundEpic(), 700);

        // Mensaje contextual
        const pct = reveal.correct_pct ?? 0;
        let msg: string | null = null;
        if (soloCorrect)            msg = "🎯 ¡SOLO VOS ACERTASTE! Sos un genio";
        else if (soloWrong)         msg = "💀 ¡Solo vos fallaste! Qué mala suerte...";
        else if (pct === 0)         msg = "💀 ¡NADIE lo sabía! Pregunta imposible";
        else if (pct === 100)       msg = "😴 Todos acertaron... demasiado fácil";
        else if (pct < 20)          msg = "🤯 ¡Casi nadie la sabía! Difícil difícil";
        else if (pct >= 80)         msg = "😎 Pan comido, todos la sabían";
        if (streakRef.current >= 3) msg = `🔥 ¡${streakRef.current} correctas seguidas! En llamas`;
        if (streakRef.current >= 5) msg = `🔥🔥 ¡${streakRef.current} EN FILA! ¡IMPARABLE!`;
        setFunMessage(msg);
      }

      if (data.type === "SCOREBOARD") {
        const newBoard = data.players as Player[];
        // Guardar posiciones anteriores antes de actualizar
        const oldPositions: Record<string, number> = {};
        scoreboardRef.current.forEach((p, i) => { oldPositions[p.nickname] = i; });
        prevPositionsRef.current = oldPositions;
        scoreboardRef.current = newBoard;
        setScoreboard(newBoard);
      }

      if (data.type === "GAME_FINISHED") {
        setPhase("FINISHED");
        if (data.players) setScoreboard(data.players as Player[]);
        soundGameOver();
        streakRef.current = 0;
        setStreakCount(0);
      }
    };

    return () => {
      socket.close();
      if (timerRef.current) clearInterval(timerRef.current);
      if (startTimerRef.current) clearInterval(startTimerRef.current);
    };
  }, []);

  const activeMode = selectedMode === "custom"
    ? customMode.trim().toLowerCase().replace(/\s+/g, "-") || "general"
    : selectedMode;

  const activeModeLabel = selectedMode === "custom"
    ? (customMode.trim() || "Personalizado")
    : PRESET_MODES.find(m => m.key === selectedMode)?.name ?? selectedMode;

  const joinGame = () => {
    const socket = ws.current;
    if (!nickname.trim() || !socket || socket.readyState !== WebSocket.OPEN) return;
    initAudio();
    nicknameRef.current = nickname.trim();
    socket.send(JSON.stringify({
      type: "JOIN_GAME",
      nickname: nickname.trim(),
      mode: activeMode,
    }));
    setPhase("LOBBY");
    // Sincronizar URL para poder compartir el link del modo
    if (typeof window !== "undefined") {
      const url = new URL(window.location.href);
      url.searchParams.set("mode", activeMode);
      window.history.replaceState({}, "", url.toString());
    }
  };

  const submitAnswer = (index: number) => {
    const socket = ws.current;
    if (selectedAnswer !== null || phase !== "QUESTION" || !socket || socket.readyState !== WebSocket.OPEN) return;
    setSelectedAnswer(index);
    socket.send(JSON.stringify({ type: "SUBMIT_ANSWER", answer: index }));
  };

  const resetGame = () => {
    if (startTimerRef.current) clearInterval(startTimerRef.current);
    countdownStartedRef.current = false;
    setPhase("SELECT");
    setScoreboard([]);
    setPlayerCount(0);
    setQuestion(null);
    setRevealData(null);
    setSelectedAnswer(null);
    setCountdown(null);
    setStartCountdown(null);
  };

  const myRank = scoreboard.findIndex((p) => p.nickname === nickname);

  const showSidebar = scoreboard.length > 0 && (phase === "QUESTION" || phase === "REVEAL");

  const getMovement = (nick: string, currentIndex: number) => {
    const prev = prevPositionsRef.current[nick];
    if (prev === undefined) return null;
    if (prev > currentIndex) return "up";
    if (prev < currentIndex) return "down";
    return "same";
  };

  return (
    <main
      className={`min-h-screen bg-black text-white flex flex-col items-center justify-center p-6 gap-6 transition-all ${
        showSidebar ? "pb-16 md:pb-6 md:pr-[13.5rem]" : ""
      }`}
    >

      {/* Nickname badge — visible en todas las fases excepto JOIN */}
      {phase !== "JOIN" && nickname && (
        <div className="fixed top-3 left-3 bg-zinc-800 border border-zinc-700 px-3 py-1.5 rounded-full text-sm">
          <span className="text-zinc-500">Jugando como </span>
          <span className="font-bold text-white">{nickname}</span>
        </div>
      )}

      {/* Barra inferior mobile — solo en pantallas chicas */}
      {showSidebar && myRank >= 0 && (
        <div className="fixed bottom-0 left-0 right-0 md:hidden bg-zinc-900 border-t border-zinc-700 px-4 py-2 flex justify-between items-center z-50">
          <span className="text-zinc-400 text-sm">Posición</span>
          <span className="text-white font-bold">
            #{myRank + 1} de {scoreboard.length}
          </span>
          <span className="text-zinc-300 text-sm font-mono">
            {scoreboard[myRank]?.score ?? 0} pts
          </span>
        </div>
      )}

      {/* Panel de posiciones lateral — oculto en mobile */}
      {showSidebar && (
        <aside className="hidden md:flex fixed right-0 top-0 h-full w-52 bg-zinc-900 border-l border-zinc-800 flex-col">
          <div className="px-3 py-3 border-b border-zinc-800">
            <p className="text-xs font-bold text-zinc-400 uppercase tracking-wider">Posiciones</p>
          </div>
          <div className="flex-1 overflow-y-auto py-1">
            {scoreboard.map((player, index) => {
              const isMe = player.nickname === nickname;
              const movement = getMovement(player.nickname, index);
              return (
                <div
                  key={player.nickname}
                  className={`flex items-center gap-1.5 px-2 py-2 mx-1 my-0.5 rounded-lg text-sm ${
                    isMe ? "bg-yellow-400/10 border border-yellow-500/30" : ""
                  }`}
                >
                  <span className="text-zinc-500 w-5 text-right text-xs font-mono shrink-0">
                    #{index + 1}
                  </span>
                  <span className="w-3 text-center text-xs shrink-0">
                    {movement === "up" && <span className="text-green-400">▲</span>}
                    {movement === "down" && <span className="text-red-400">▼</span>}
                    {movement === "same" && <span className="text-zinc-600">—</span>}
                  </span>
                  <span className={`flex-1 truncate text-xs ${isMe ? "text-yellow-400 font-bold" : "text-zinc-300"}`}>
                    {player.nickname}
                  </span>
                  {player.answered_count != null && player.answered_count > 0 && (
                    <span className="text-zinc-500 text-xs shrink-0 mr-1.5">
                      <span className="text-green-400">{player.correct_count}</span>
                      <span className="text-zinc-600">/{player.answered_count}</span>
                    </span>
                  )}
                  <span className="text-zinc-400 text-xs font-mono shrink-0">
                    {player.score}
                  </span>
                </div>
              );
            })}
          </div>
          {myRank >= 0 && (
            <div className="border-t border-zinc-800 px-3 py-2 text-center">
              <p className="text-xs text-zinc-500">
                Estás <span className="text-white font-bold">#{myRank + 1}</span> de {scoreboard.length}
              </p>
            </div>
          )}
        </aside>
      )}

      <h1 className="text-5xl font-bold tracking-tight">100×100</h1>

      {/* SELECT — elegir modo */}
      {phase === "SELECT" && (
        <div className="flex flex-col items-center gap-6 w-full max-w-lg animate-zoom-in-fast">
          <p className="text-zinc-400 text-sm tracking-wide">¿Qué tipo de partida querés jugar?</p>

          <div className="grid grid-cols-2 sm:grid-cols-3 gap-3 w-full">
            {PRESET_MODES.map((m) => {
              const isSelected = selectedMode === m.key;
              return (
                <button
                  key={m.key}
                  onClick={() => setSelectedMode(m.key)}
                  className={`p-4 rounded-xl text-left border-2 transition-all duration-150 ${
                    isSelected
                      ? "border-red-500 bg-red-500/10 scale-95"
                      : "border-zinc-700 hover:border-zinc-500 hover:bg-zinc-800/50"
                  }`}
                >
                  <div className="text-2xl">{m.emoji}</div>
                  <div className="font-bold text-sm mt-1 text-white">{m.name}</div>
                  <div className="text-zinc-500 text-xs mt-0.5">{m.desc}</div>
                  {m.key !== "custom" && modeCounts[m.key] != null && (
                    <div className="text-zinc-600 text-xs mt-1">
                      {modeCounts[m.key].toLocaleString()} preguntas
                    </div>
                  )}
                </button>
              );
            })}
          </div>

          {selectedMode === "custom" && (
            <div className="w-full space-y-3 animate-zoom-in-fast">
              {secondaryModes.length > 0 && (
                <div>
                  <p className="text-zinc-500 text-xs mb-2 text-center">
                    Modos disponibles — hacé click para elegir:
                  </p>
                  <div className="flex flex-wrap gap-2 justify-center">
                    {secondaryModes.map((m) => {
                      const label = m.mode.replace(/_/g, " ");
                      const isSelected = customMode === m.mode;
                      return (
                        <button
                          key={m.mode}
                          onClick={() => setCustomMode(m.mode)}
                          className={`px-3 py-1.5 rounded-full text-sm border transition-all ${
                            isSelected
                              ? "border-red-500 bg-red-500/20 text-white font-bold"
                              : "border-zinc-600 text-zinc-300 hover:border-zinc-400 hover:text-white"
                          }`}
                        >
                          {label}
                          <span className="ml-1.5 text-zinc-500 text-xs">
                            {m.count}
                          </span>
                        </button>
                      );
                    })}
                  </div>
                </div>
              )}
              <div className="flex flex-col gap-1">
                <p className="text-zinc-600 text-xs text-center">
                  O escribí uno nuevo:
                </p>
                <input
                  autoFocus={secondaryModes.length === 0}
                  className="bg-zinc-800 border border-zinc-600 text-white px-4 py-2 rounded-lg w-full text-center placeholder-zinc-500 focus:border-red-500 focus:outline-none"
                  placeholder="ej: bahia-blanca, 4to-ing-industrial..."
                  value={customMode}
                  onChange={(e) => setCustomMode(e.target.value)}
                  onKeyDown={(e) => e.key === "Enter" && setPhase("JOIN")}
                  maxLength={40}
                />
              </div>
            </div>
          )}

          <button
            onClick={() => setPhase("JOIN")}
            disabled={selectedMode === "custom" && !customMode.trim()}
            className="bg-red-600 hover:bg-red-500 disabled:opacity-40 disabled:cursor-not-allowed px-10 py-3 rounded-lg text-lg font-bold transition-colors w-full"
          >
            {selectedMode === "custom" && customMode.trim()
              ? `Jugar "${customMode.trim()}" →`
              : selectedMode !== "custom"
              ? `Jugar ${PRESET_MODES.find(m => m.key === selectedMode)?.name} →`
              : "Escribí el modo primero"}
          </button>
        </div>
      )}

      {/* JOIN — ingresar nickname */}
      {phase === "JOIN" && (
        <div className="flex flex-col items-center gap-4 animate-zoom-in-fast">
          <div className="text-zinc-400 text-sm">
            Modo: <span className="text-white font-bold">{activeModeLabel}</span>
            <button
              onClick={() => setPhase("SELECT")}
              className="ml-3 text-zinc-600 hover:text-zinc-400 text-xs underline"
            >
              cambiar
            </button>
          </div>
          <input
            autoFocus
            className="bg-white text-black px-4 py-3 rounded-lg text-lg w-64 text-center font-medium placeholder-zinc-400"
            placeholder="Tu nickname"
            value={nickname}
            onChange={(e) => setNickname(e.target.value)}
            onKeyDown={(e) => e.key === "Enter" && joinGame()}
            maxLength={20}
          />
          <button
            className="bg-red-600 hover:bg-red-500 disabled:opacity-40 disabled:cursor-not-allowed px-10 py-3 rounded-lg text-xl font-bold transition-colors"
            onClick={joinGame}
            disabled={!nickname.trim()}
          >
            JUGAR
          </button>
        </div>
      )}

      {/* LOBBY */}
      {phase === "LOBBY" && (
        <div className="text-center flex flex-col items-center gap-3">
          <div className="text-xs text-zinc-600 uppercase tracking-widest font-bold mb-1">
            {activeModeLabel}
          </div>
          <div className="text-7xl font-bold text-red-500">{playerCount}</div>
          <div className="text-zinc-300 text-lg">
            jugador{playerCount !== 1 ? "es" : ""} en sala
          </div>

          {startCountdown !== null ? (
            <div className="flex flex-col items-center gap-1 mt-2">
              <div className="text-4xl font-bold text-yellow-400">{startCountdown}s</div>
              <div className="text-zinc-400 text-sm">para que empiece la partida</div>
              <div className="text-zinc-600 text-xs mt-1">
                Pueden unirse hasta {10} jugadores
              </div>
            </div>
          ) : (
            <div className="text-zinc-500 text-sm mt-2 animate-pulse">
              Esperando más jugadores...
            </div>
          )}
        </div>
      )}

      {/* COUNTDOWN */}
      {phase === "COUNTDOWN" && countdown !== null && (
        <div className="text-9xl font-bold text-red-500 animate-pulse">{countdown}</div>
      )}

      {/* QUESTION */}
      {phase === "QUESTION" && question && (
        <div className="flex flex-col gap-4 w-full max-w-xl">
          <div className="flex justify-between items-center text-sm text-zinc-400">
            <span>
              Pregunta {question.question_number}/{question.total_questions}
            </span>
            <span className={`font-bold text-lg ${
              timeLeft <= 3
                ? "text-red-500 animate-pulse-urgent"
                : "text-white"
            }`}>
              {timeLeft}s
            </span>
          </div>

          <div className="w-full bg-zinc-800 rounded-full h-1.5">
            <div
              className={`h-1.5 rounded-full transition-all duration-200 ${timeLeft <= 3 ? "bg-red-500" : "bg-red-400"}`}
              style={{ width: `${(timeLeft / (question.duration || 10)) * 100}%` }}
            />
          </div>

          <h2 className="text-2xl text-center font-semibold mt-1 leading-snug">
            {question.question}
          </h2>

          <div className="grid grid-cols-2 gap-3 mt-1">
            {question.options.map((option, index) => {
              const isSelected = selectedAnswer === index;
              const isLocked = selectedAnswer !== null;
              return (
                <button
                  key={index}
                  className={`
                    ${OPTION_COLORS[index]}
                    ${isSelected ? "ring-4 ring-white scale-95" : ""}
                    ${isLocked && !isSelected ? "opacity-40 cursor-default" : "active:scale-95"}
                    p-4 rounded-lg text-base font-medium transition-all duration-150 text-left
                  `}
                  onClick={() => submitAnswer(index)}
                  disabled={isLocked}
                >
                  <span className="font-bold mr-2">{["A", "B", "C", "D"][index]}.</span>
                  {option}
                </button>
              );
            })}
          </div>

          {selectedAnswer !== null && (
            <p className="text-center text-zinc-400 text-sm animate-pulse">
              Respuesta enviada — esperando a los demás...
            </p>
          )}
        </div>
      )}

      {/* REVEAL */}
      {phase === "REVEAL" && revealData && question && (
        <div className="flex flex-col gap-4 w-full max-w-xl items-center">
          {/* Opciones con correcto/incorrecto */}
          <div className="grid grid-cols-2 gap-2 w-full">
            {question.options.map((option, index) => {
              const isCorrect = index === revealData.correct_index;
              const wasSelected = selectedAnswer === index;
              const isWrong = wasSelected && !isCorrect;
              return (
                <div
                  key={index}
                  className={`
                    p-3 rounded-lg text-sm font-medium text-left transition-all animate-zoom-in-fast
                    ${isCorrect ? "bg-green-600 ring-2 ring-green-400 animate-glow-green" : OPTION_COLORS_BASE[index]}
                    ${isWrong ? "opacity-40 line-through animate-shake" : ""}
                    ${isCorrect && wasSelected ? "scale-105" : ""}
                  `}
                  style={{ animationDelay: `${index * 80}ms` }}
                >
                  <span className="font-bold mr-1">{["A", "B", "C", "D"][index]}.</span>
                  {option}
                </div>
              );
            })}
          </div>

          {/* Resultado personal */}
          <div className="flex flex-col items-center gap-1">
            <div className="flex items-center gap-3">
              {selectedAnswer !== null ? (
                <span className={`text-2xl font-bold ${
                  answerAnim === "correct"
                    ? "text-green-400 animate-bounce-correct"
                    : answerAnim === "wrong"
                    ? "text-red-400 animate-shake"
                    : selectedAnswer === revealData.correct_index ? "text-green-400" : "text-red-400"
                }`}>
                  {selectedAnswer === revealData.correct_index ? "✓ ¡Correcto!" : "✗ Incorrecto"}
                </span>
              ) : (
                <span className="text-2xl font-bold text-zinc-500">Sin respuesta</span>
              )}
              {floatingPts != null && floatingPts > 0 && (
                <span className="text-green-300 font-bold text-lg animate-float-score">
                  +{floatingPts}
                </span>
              )}
            </div>
            <span className="text-zinc-500 text-sm">
              {revealData.correct_pct}% de jugadores acertó
            </span>
          </div>

          {/* Mensaje épico / racha */}
          {funMessage && (
            <div className="text-center text-base font-bold text-yellow-300 animate-epic-pop px-4 py-2 bg-yellow-400/10 rounded-xl border border-yellow-400/20">
              {funMessage}
            </div>
          )}

          {/* Tabla de resultados de esta pregunta */}
          {revealData.question_results && revealData.question_results.length > 0 && (
            <div className="w-full bg-zinc-900 border border-zinc-800 rounded-xl overflow-hidden">
              <div className="px-4 py-2 border-b border-zinc-800">
                <p className="text-xs font-bold text-zinc-400 uppercase tracking-wider">
                  Esta pregunta
                </p>
              </div>
              <div className="divide-y divide-zinc-800">
                {revealData.question_results.map((r, i) => {
                  const isMe = r.nickname === nickname;
                  return (
                    <div
                      key={i}
                      className={`flex items-center gap-3 px-4 py-2 text-sm ${
                        isMe ? "bg-yellow-400/10" : ""
                      }`}
                    >
                      {/* ícono resultado */}
                      <span className="w-5 text-center text-base shrink-0">
                        {r.correct === true && "✓"}
                        {r.correct === false && "✗"}
                        {r.correct === null && "—"}
                      </span>

                      {/* nickname */}
                      <span className={`flex-1 truncate ${
                        isMe ? "text-yellow-400 font-bold" : "text-zinc-300"
                      }`}>
                        {r.nickname}
                      </span>

                      {/* tiempo */}
                      <span className="text-zinc-500 text-xs w-10 text-right shrink-0">
                        {r.response_time_ms !== null
                          ? `${(r.response_time_ms / 1000).toFixed(1)}s`
                          : "—"}
                      </span>

                      {/* puntos */}
                      <span className={`text-xs font-mono w-16 text-right shrink-0 ${
                        r.points_earned > 0 ? "text-green-400" : "text-zinc-600"
                      }`}>
                        {r.points_earned > 0 ? `+${r.points_earned}` : "0"}
                      </span>
                    </div>
                  );
                })}
              </div>
            </div>
          )}
        </div>
      )}

      {/* SCOREBOARD FINAL */}
      {scoreboard.length > 0 && phase === "FINISHED" && (
        <div className="w-full max-w-lg bg-zinc-900 border border-zinc-800 rounded-xl overflow-hidden">
          <div className="px-4 py-3 border-b border-zinc-800 grid grid-cols-12 text-xs text-zinc-500 font-medium uppercase tracking-wider">
            <span className="col-span-1">#</span>
            <span className="col-span-4">Jugador</span>
            <span className="col-span-2 text-center">Pts</span>
            <span className="col-span-2 text-center">Aciertos</span>
            <span className="col-span-3 text-center">Vel. prom.</span>
          </div>
          {scoreboard.map((player, index) => {
            const isMe = player.nickname === nickname;
            const total = player.answered_count ?? 0;
            const correct = player.correct_count ?? 0;
            const avg = player.avg_time_ms;
            return (
              <div
                key={index}
                className={`grid grid-cols-12 items-center px-4 py-2.5 border-b border-zinc-800 last:border-0 text-sm ${
                  isMe ? "bg-yellow-400/10 text-yellow-400 font-bold" : "text-zinc-300"
                }`}
              >
                <span className="col-span-1 text-zinc-500 text-xs">#{index + 1}</span>
                <span className="col-span-4 truncate">
                  {player.nickname}
                  {isMe && <span className="ml-1 text-xs text-yellow-600 font-normal">(tú)</span>}
                </span>
                <span className="col-span-2 text-center font-mono">{player.score}</span>
                <span className="col-span-2 text-center">
                  <span className="text-green-400">{correct}</span>
                  <span className="text-zinc-600">/{total}</span>
                </span>
                <span className="col-span-3 text-center text-zinc-400">
                  {avg != null ? `${(avg / 1000).toFixed(1)}s` : "—"}
                </span>
              </div>
            );
          })}
        </div>
      )}

      {/* FINISHED */}
      {phase === "FINISHED" && (
        <div className="text-center flex flex-col items-center gap-4">
          <div className="text-4xl font-bold text-yellow-400">¡Partida finalizada!</div>
          {myRank >= 0 && (
            <div className="text-zinc-300 text-lg">
              Terminaste en el puesto{" "}
              <span className="font-bold text-white">#{myRank + 1}</span>
            </div>
          )}
          <button
            className="mt-2 bg-red-600 hover:bg-red-500 px-8 py-3 rounded-lg text-lg font-bold transition-colors"
            onClick={resetGame}
          >
            Jugar de nuevo
          </button>
        </div>
      )}
      {/* Overlay de conexión perdida — solo visible si estabas en el juego */}
      {!connected && phase !== "JOIN" && (
        <div className="fixed inset-0 bg-black/90 z-50 flex items-center justify-center">
          <div className="text-center flex flex-col gap-3">
            <p className="text-3xl font-bold text-red-400">Conexión perdida</p>
            <p className="text-zinc-400">Se cortó la conexión con el servidor</p>
            <button
              className="mt-4 bg-zinc-700 hover:bg-zinc-600 px-6 py-2 rounded-lg text-sm"
              onClick={() => window.location.reload()}
            >
              Recargar página
            </button>
          </div>
        </div>
      )}
    </main>
  );
}
