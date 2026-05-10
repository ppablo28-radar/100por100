"use client";

import { useEffect, useRef, useState } from "react";

type Phase = "JOIN" | "LOBBY" | "COUNTDOWN" | "QUESTION" | "REVEAL" | "FINISHED";

type QuestionData = {
  question: string;
  options: string[];
  duration: number;
  question_number: number;
  total_questions: number;
};

type RevealData = {
  correct: string;
  correct_index: number;
  correct_pct: number;
};

type Player = {
  nickname: string;
  score: number;
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

  const [nickname, setNickname] = useState("");
  const [phase, setPhase] = useState<Phase>("JOIN");
  const [playerCount, setPlayerCount] = useState(0);
  const [countdown, setCountdown] = useState<number | null>(null);
  const [startCountdown, setStartCountdown] = useState<number | null>(null);
  const [question, setQuestion] = useState<QuestionData | null>(null);
  const [selectedAnswer, setSelectedAnswer] = useState<number | null>(null);
  const [timeLeft, setTimeLeft] = useState(0);
  const [revealData, setRevealData] = useState<RevealData | null>(null);
  const [scoreboard, setScoreboard] = useState<Player[]>([]);
  const [connected, setConnected] = useState(false);

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
      }

      if (data.type === "NEW_QUESTION") {
        setPhase("QUESTION");
        setQuestion(data as QuestionData);
        setSelectedAnswer(null);
        setRevealData(null);

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
        setPhase("REVEAL");
        setRevealData(data as RevealData);
        if (timerRef.current) clearInterval(timerRef.current);
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
      }
    };

    return () => {
      socket.close();
      if (timerRef.current) clearInterval(timerRef.current);
      if (startTimerRef.current) clearInterval(startTimerRef.current);
    };
  }, []);

  const joinGame = () => {
    const socket = ws.current;
    if (!nickname.trim() || !socket || socket.readyState !== WebSocket.OPEN) return;
    socket.send(JSON.stringify({ type: "JOIN_GAME", nickname: nickname.trim() }));
    setPhase("LOBBY");
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
    setPhase("JOIN");
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
      className="min-h-screen bg-black text-white flex flex-col items-center justify-center p-6 gap-6"
      style={{ paddingRight: showSidebar ? "13.5rem" : undefined }}
    >

      {/* Nickname badge — visible en todas las fases excepto JOIN */}
      {phase !== "JOIN" && nickname && (
        <div className="fixed top-3 left-3 bg-zinc-800 border border-zinc-700 px-3 py-1.5 rounded-full text-sm">
          <span className="text-zinc-500">Jugando como </span>
          <span className="font-bold text-white">{nickname}</span>
        </div>
      )}

      {/* Panel de posiciones lateral */}
      {showSidebar && (
        <aside className="fixed right-0 top-0 h-full w-52 bg-zinc-900 border-l border-zinc-800 flex flex-col">
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

      {/* JOIN */}
      {phase === "JOIN" && (
        <div className="flex flex-col items-center gap-4">
          <input
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
            <span className={`font-bold text-lg ${timeLeft <= 3 ? "text-red-500" : "text-white"}`}>
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
          <h2 className="text-xl text-center text-zinc-300 leading-snug">
            {question.question}
          </h2>

          <div className="grid grid-cols-2 gap-3 w-full">
            {question.options.map((option, index) => {
              const isCorrect = index === revealData.correct_index;
              const wasSelected = selectedAnswer === index;
              const isWrong = wasSelected && !isCorrect;
              return (
                <div
                  key={index}
                  className={`
                    p-4 rounded-lg text-base font-medium text-left transition-all
                    ${isCorrect ? "bg-green-600 ring-4 ring-green-400" : OPTION_COLORS_BASE[index]}
                    ${isWrong ? "opacity-50 line-through" : ""}
                    ${isCorrect && wasSelected ? "scale-105" : ""}
                  `}
                >
                  <span className="font-bold mr-2">{["A", "B", "C", "D"][index]}.</span>
                  {option}
                </div>
              );
            })}
          </div>

          {selectedAnswer !== null ? (
            <div
              className={`text-2xl font-bold ${
                selectedAnswer === revealData.correct_index ? "text-green-400" : "text-red-400"
              }`}
            >
              {selectedAnswer === revealData.correct_index ? "✓ ¡Correcto!" : "✗ Incorrecto"}
            </div>
          ) : (
            <div className="text-2xl font-bold text-zinc-500">Sin respuesta</div>
          )}

          <div className="text-zinc-400 text-sm">
            {revealData.correct_pct}% de jugadores acertó
          </div>
        </div>
      )}

      {/* SCOREBOARD */}
      {scoreboard.length > 0 && (phase === "REVEAL" || phase === "FINISHED") && (
        <div className="w-full max-w-md bg-zinc-900 border border-zinc-800 p-4 rounded-xl">
          <h2 className="text-lg font-bold mb-3 text-zinc-300">Ranking</h2>
          {scoreboard.map((player, index) => {
            const isMe = player.nickname === nickname;
            return (
              <div
                key={index}
                className={`flex justify-between py-2 border-b border-zinc-800 last:border-0 ${
                  isMe ? "text-yellow-400 font-bold" : "text-zinc-300"
                }`}
              >
                <span>
                  <span className="text-zinc-500 mr-2">#{index + 1}</span>
                  {player.nickname}
                  {isMe && <span className="ml-2 text-xs text-yellow-600">(tú)</span>}
                </span>
                <span>{player.score} pts</span>
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
