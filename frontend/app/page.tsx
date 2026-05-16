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
  question_type: string;
  options: (string | {id: string; name: string})[];
  events?: {id: string; title: string; hint?: string}[];
  attribute_name?: string;
  unit?: string;
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
  question_type?: string;
  // multiple_choice
  correct?: string;
  correct_index?: number;
  // higher_lower
  correct_id?: string;
  correct_name?: string;
  values?: Record<string, number>;
  attribute_name?: string;
  unit?: string;
  options?: {id: string; name: string}[];
  // timeline_order
  correct_order?: string[];
  correct_order_titles?: string[];
  events?: {id: string; title: string}[];
  // common
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

// ─── Configuración de generadores ────────────────────────────────────────────
const GENERATOR_GROUPS = [
  {
    label: "🌍 Países · Población",
    slugs: ["higher-lower-paises-poblacion","ranking-paises-poblacion","closest-number-paises-poblacion"],
    short: ["Más Población","Ordenar Pob.","Adivinar Pob."],
  },
  {
    label: "🌍 Países · Superficie",
    slugs: ["higher-lower-paises-area","ranking-paises-area","closest-number-paises-area"],
    short: ["Más Superficie","Ordenar Sup.","Adivinar Sup."],
  },
  {
    label: "📺 YouTubers · Suscriptores",
    slugs: ["higher-lower-youtubers-subs","ranking-youtubers-subs","closest-number-youtubers-subs"],
    short: ["Más Subs","Ordenar Subs","Adivinar Subs"],
  },
  {
    label: "🎮 Juegos · Año",
    slugs: ["higher-lower-games-year","ranking-games-year","closest-number-games-year"],
    short: ["Más Reciente","Ordenar Año","Adivinar Año"],
  },
  {
    label: "🎮 Juegos · Ventas",
    slugs: ["higher-lower-games-sales","ranking-games-sales","closest-number-games-sales"],
    short: ["Más Ventas","Ordenar Ventas","Adivinar Ventas"],
  },
] as const;

const ALL_SLUGS = GENERATOR_GROUPS.flatMap(g => [...g.slugs]);

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
  const [generatorSlug, setGeneratorSlug] = useState<string | null>(null);
  const [showDebug, setShowDebug] = useState(false);
  const debugLogRef = useRef<string[]>([]);
  const [selectedSlugs, setSelectedSlugs] = useState<Set<string>>(new Set(ALL_SLUGS));
  const [engineSlugs, setEngineSlugs] = useState<Set<string>>(new Set());
  // Pregunta procedural — timeline_order
  const [timelineOrder, setTimelineOrder] = useState<string[]>([]);
  const timelineSubmittedRef = useRef(false);
  // Pregunta procedural — higher_lower
  const [selectedAnswerId, setSelectedAnswerId] = useState<string | null>(null);
  // Pregunta procedural — closest_number (ahora multiple choice)
  const [closestSubmitted, setClosestSubmitted] = useState(false);
  // Pregunta procedural — ranking_order (drag-and-drop)
  const [rankingItems, setRankingItems] = useState<{id: string; name: string}[]>([]);
  const [rankingSubmitted, setRankingSubmitted] = useState(false);
  const rankingDragIdx = useRef<number | null>(null);

  // Beep en los últimos 3 segundos de cada pregunta
  useEffect(() => {
    if (phase === "QUESTION" && timeLeft <= 3 && timeLeft > 0) {
      if (lastBeepRef.current !== timeLeft) {
        lastBeepRef.current = timeLeft;
        soundCountdownBeep();
      }
    }
  }, [timeLeft, phase]);

  // Auto-submit ranking_order cuando se acaba el tiempo
  useEffect(() => {
    if (
      phase === "QUESTION" &&
      question?.question_type === "ranking_order" &&
      timeLeft <= 1 &&
      !rankingSubmitted &&
      rankingItems.length > 0
    ) {
      submitRanking();
    }
  }, [timeLeft]);

  const dbg = (msg: string) => {
    const ts = new Date().toISOString().slice(11, 23);
    debugLogRef.current = [...debugLogRef.current.slice(-60), `[${ts}] ${msg}`];
  };

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

  // Al entrar en JOIN, cargar los slugs reales del engine
  useEffect(() => {
    if (phase !== "JOIN") return;
    fetch(`${apiBase}/procedural/stats`)
      .then(r => r.json())
      .then(data => {
        const slugs = new Set<string>((data.generators ?? []).map((g: {slug: string}) => g.slug));
        setEngineSlugs(slugs);
        // Preseleccionar solo los que existen en el engine
        setSelectedSlugs(prev => new Set([...prev].filter(s => slugs.has(s))));
      })
      .catch(() => {});
  }, [phase]);

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

    socket.onopen = () => { setConnected(true); dbg(`WS conectado → ${WS_URL}`); };
    socket.onclose = () => {
      setConnected(ws.current?.readyState === WebSocket.OPEN);
      dbg("WS desconectado");
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
        const slug = data.debug?.generator_slug ?? "handcrafted";
        setGeneratorSlug(slug);
        dbg(`PREGUNTA ${data.question_number}/${data.total_questions} · ${slug} · ${data.question_type} · ${data.duration}s`);
        setPhase("QUESTION");
        setQuestion(data as QuestionData);
        setSelectedAnswer(null);
        setSelectedAnswerId(null);
        setTimelineOrder([]);
        timelineSubmittedRef.current = false;
        setClosestSubmitted(false);
        setRankingSubmitted(false);
        if (data.question_type === "ranking_order" && Array.isArray(data.options)) {
          const shuffled = [...(data.options as {id:string;name:string}[])].sort(() => Math.random() - 0.5);
          setRankingItems(shuffled);
        } else {
          setRankingItems([]);
        }
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

      if (data.type === "ERROR") {
        dbg(`ERROR servidor: ${data.message}`);
        alert(`Error del servidor: ${data.message ?? "error desconocido"}`);
        resetGame();
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
    const slugs = [...selectedSlugs];
    dbg(`JOIN_GAME nick=${nickname.trim()} mode=${activeMode} slugs=${slugs.length}`);
    socket.send(JSON.stringify({
      type: "JOIN_GAME",
      nickname: nickname.trim(),
      mode: activeMode,
      selected_slugs: slugs,
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

  const submitClosestNumber = (id: string) => {
    const socket = ws.current;
    if (closestSubmitted || phase !== "QUESTION" || !socket || socket.readyState !== WebSocket.OPEN) return;
    setClosestSubmitted(true);
    setSelectedAnswerId(id);
    socket.send(JSON.stringify({ type: "SUBMIT_ANSWER", answer: id }));
  };

  const submitRanking = () => {
    const socket = ws.current;
    if (rankingSubmitted || phase !== "QUESTION" || !socket || socket.readyState !== WebSocket.OPEN) return;
    setRankingSubmitted(true);
    socket.send(JSON.stringify({ type: "SUBMIT_ANSWER", answer: rankingItems.map(i => i.id) }));
  };

  const submitHigherLower = (id: string) => {
    const socket = ws.current;
    if (selectedAnswerId !== null || phase !== "QUESTION" || !socket || socket.readyState !== WebSocket.OPEN) return;
    setSelectedAnswerId(id);
    socket.send(JSON.stringify({ type: "SUBMIT_ANSWER", answer: id }));
  };

  const clickTimelineEvent = (id: string) => {
    const socket = ws.current;
    if (timelineSubmittedRef.current || phase !== "QUESTION" || !socket || socket.readyState !== WebSocket.OPEN) return;
    if (timelineOrder.includes(id)) return;
    const newOrder = [...timelineOrder, id];
    setTimelineOrder(newOrder);
    // timeline_order usa events, ranking_order usa options
    const totalItems = question?.question_type === "ranking_order"
      ? (question?.options ?? []).length
      : (question?.events ?? []).length;
    if (newOrder.length === totalItems) {
      timelineSubmittedRef.current = true;
      socket.send(JSON.stringify({ type: "SUBMIT_ANSWER", answer: newOrder }));
    }
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

      {/* Generator label — visible durante QUESTION y REVEAL */}
      {(phase === "QUESTION" || phase === "REVEAL") && (
        <div className="text-xs text-zinc-400 font-mono tracking-wide -mb-4 px-3 py-1 bg-zinc-800/60 rounded-full border border-zinc-700">
          {generatorSlug ?? "cargando..."}
        </div>
      )}

      <h1 className="text-5xl font-bold tracking-tight">100×100</h1>

      {/* Botón debug — siempre visible en esquina */}
      <button
        onClick={() => setShowDebug(d => !d)}
        className="fixed bottom-4 left-4 z-50 bg-zinc-800 hover:bg-zinc-700 border border-zinc-600 text-zinc-400 text-xs px-2 py-1 rounded font-mono"
      >
        {showDebug ? "✕ debug" : "🐛 debug"}
      </button>

      {/* Panel de debug */}
      {showDebug && (
        <div className="fixed bottom-12 left-4 z-50 w-80 max-h-96 bg-zinc-950 border border-zinc-700 rounded-xl shadow-2xl flex flex-col text-xs font-mono">
          <div className="flex justify-between items-center px-3 py-2 border-b border-zinc-800">
            <span className="text-zinc-400 font-bold">Debug Panel</span>
            <button
              onClick={() => {
                const info = [
                  `=== 100x100 Debug ===`,
                  `Fecha: ${new Date().toISOString()}`,
                  `WS: ${process.env.NEXT_PUBLIC_WS_URL ?? "ws://127.0.0.1:8000/ws"}`,
                  `Backend: ${apiBase}`,
                  `Conectado: ${connected}`,
                  `Phase: ${phase}`,
                  `Modo: ${activeMode}`,
                  `Nickname: ${nicknameRef.current}`,
                  `Generator: ${generatorSlug ?? "ninguno"}`,
                  `Jugadores: ${scoreboard.length}`,
                  ``,
                  `=== Log ===`,
                  ...debugLogRef.current,
                ].join("\n");
                navigator.clipboard.writeText(info);
              }}
              className="text-blue-400 hover:text-blue-300"
            >
              📋 copiar
            </button>
          </div>
          <div className="px-3 py-2 border-b border-zinc-800 space-y-1 text-zinc-500">
            <div><span className="text-zinc-400">WS:</span> {connected ? "✅ conectado" : "❌ desconectado"}</div>
            <div><span className="text-zinc-400">Phase:</span> {phase}</div>
            <div><span className="text-zinc-400">Modo:</span> {activeMode}</div>
            <div><span className="text-zinc-400">Generator:</span> <span className="text-green-400">{generatorSlug ?? "—"}</span></div>
            <div><span className="text-zinc-400">Backend:</span> {apiBase}</div>
          </div>
          <div className="flex-1 overflow-y-auto px-3 py-2 space-y-0.5">
            {[...debugLogRef.current].reverse().map((line, i) => (
              <div key={i} className="text-zinc-500 leading-4">{line}</div>
            ))}
          </div>
        </div>
      )}

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

      {/* JOIN — ingresar nickname + selector de generadores */}
      {phase === "JOIN" && (
        <div className="flex flex-col items-center gap-4 animate-zoom-in-fast w-full max-w-lg">
          <div className="text-zinc-400 text-sm">
            Modo: <span className="text-white font-bold">{activeModeLabel}</span>
            <button onClick={() => setPhase("SELECT")} className="ml-3 text-zinc-600 hover:text-zinc-400 text-xs underline">cambiar</button>
          </div>
          <input
            autoFocus
            className="bg-white text-black px-4 py-3 rounded-lg text-lg w-64 text-center font-medium placeholder-zinc-400"
            placeholder="Tu nickname"
            value={nickname}
            onChange={(e) => setNickname(e.target.value)}
            onKeyDown={(e) => e.key === "Enter" && nickname.trim() && joinGame()}
            maxLength={20}
          />

          {/* Selector de generadores */}
          <div className="w-full bg-zinc-900 border border-zinc-800 rounded-xl p-4 flex flex-col gap-3">
            <div className="flex justify-between items-center">
              <span className="text-zinc-400 text-sm font-semibold">Preguntas a jugar</span>
              <div className="flex gap-2">
                <button onClick={() => setSelectedSlugs(new Set(ALL_SLUGS))} className="text-xs text-blue-400 hover:text-blue-300">Todas</button>
                <span className="text-zinc-700">·</span>
                <button onClick={() => setSelectedSlugs(new Set())} className="text-xs text-zinc-500 hover:text-zinc-400">Ninguna</button>
              </div>
            </div>

            {GENERATOR_GROUPS.map((group) => {
              const available = group.slugs.filter(s => engineSlugs.size === 0 || engineSlugs.has(s));
              if (available.length === 0) return null;
              const allIn = available.every(s => selectedSlugs.has(s));
              return (
                <div key={group.label} className="flex flex-col gap-1.5">
                  <div className="flex items-center justify-between">
                    <span className="text-xs text-zinc-500 font-medium">{group.label}</span>
                    <button
                      onClick={() => {
                        const next = new Set(selectedSlugs);
                        available.forEach(s => allIn ? next.delete(s) : next.add(s));
                        setSelectedSlugs(next);
                      }}
                      className="text-xs text-zinc-600 hover:text-zinc-400"
                    >
                      {allIn ? "quitar" : "agregar"}
                    </button>
                  </div>
                  <div className="flex flex-wrap gap-2">
                    {group.slugs.map((slug, i) => {
                      if (engineSlugs.size > 0 && !engineSlugs.has(slug)) return null;
                      const on = selectedSlugs.has(slug);
                      return (
                        <button
                          key={slug}
                          onClick={() => {
                            const next = new Set(selectedSlugs);
                            on ? next.delete(slug) : next.add(slug);
                            setSelectedSlugs(next);
                          }}
                          className={`px-3 py-1.5 rounded-lg text-xs font-medium border transition-all ${
                            on ? "bg-red-600/20 border-red-500/60 text-red-300"
                               : "bg-zinc-800 border-zinc-700 text-zinc-600"
                          }`}
                        >
                          {group.short[i]}
                        </button>
                      );
                    })}
                  </div>
                </div>
              );
            })}

            <div className="text-center text-zinc-500 text-xs pt-1 border-t border-zinc-800">
              {selectedSlugs.size === 0
                ? "⚠️ Seleccioná al menos 1 pregunta"
                : `${selectedSlugs.size} pregunta${selectedSlugs.size !== 1 ? "s" : ""} · una de cada una`}
            </div>
          </div>

          <button
            className="bg-red-600 hover:bg-red-500 disabled:opacity-40 disabled:cursor-not-allowed px-10 py-3 rounded-lg text-xl font-bold transition-colors w-full"
            onClick={joinGame}
            disabled={!nickname.trim() || selectedSlugs.size === 0}
          >
            JUGAR ({selectedSlugs.size} preguntas)
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
            <span>Pregunta {question.question_number}/{question.total_questions}</span>
            <span className={`font-bold text-lg ${timeLeft <= 3 ? "text-red-500 animate-pulse-urgent" : "text-white"}`}>
              {timeLeft}s
            </span>
          </div>
          <div className="w-full bg-zinc-800 rounded-full h-1.5">
            <div
              className={`h-1.5 rounded-full transition-all duration-200 ${timeLeft <= 3 ? "bg-red-500" : "bg-red-400"}`}
              style={{ width: `${(timeLeft / (question.duration || 10)) * 100}%` }}
            />
          </div>
          <h2 className="text-2xl text-center font-semibold mt-1 leading-snug">{question.question}</h2>

          {/* ── Multiple choice (existente) ── */}
          {(!question.question_type || question.question_type === "multiple_choice") && (
            <>
              <div className="grid grid-cols-2 gap-3 mt-1">
                {(question.options as string[]).map((option, index) => {
                  const isSelected = selectedAnswer === index;
                  const isLocked = selectedAnswer !== null;
                  return (
                    <button
                      key={index}
                      className={`${OPTION_COLORS[index]} ${isSelected ? "ring-4 ring-white scale-95" : ""} ${isLocked && !isSelected ? "opacity-40 cursor-default" : "active:scale-95"} p-4 rounded-lg text-base font-medium transition-all duration-150 text-left`}
                      onClick={() => submitAnswer(index)}
                      disabled={isLocked}
                    >
                      <span className="font-bold mr-2">{["A","B","C","D"][index]}.</span>
                      {option}
                    </button>
                  );
                })}
              </div>
              {selectedAnswer !== null && (
                <p className="text-center text-zinc-400 text-sm animate-pulse">Respuesta enviada — esperando a los demás...</p>
              )}
            </>
          )}

          {/* ── Higher / Lower (2-10 opciones) ── */}
          {question.question_type === "higher_lower" && (() => {
            const opts = question.options as {id: string; name: string}[];
            const isLocked = selectedAnswerId !== null;
            const BG = ["bg-blue-700 hover:bg-blue-600","bg-red-700 hover:bg-red-600","bg-yellow-600 hover:bg-yellow-500","bg-green-700 hover:bg-green-600","bg-purple-700 hover:bg-purple-600","bg-pink-700 hover:bg-pink-600","bg-orange-600 hover:bg-orange-500","bg-teal-700 hover:bg-teal-600","bg-indigo-700 hover:bg-indigo-600","bg-cyan-700 hover:bg-cyan-600"];
            return (
              <>
                {question.attribute_name && (
                  <p className="text-center text-zinc-500 text-sm -mt-2">
                    {question.attribute_name}{question.unit ? ` (${question.unit})` : ""}
                  </p>
                )}
                <div className={`grid gap-3 mt-1 ${opts.length <= 2 ? "grid-cols-2" : opts.length <= 4 ? "grid-cols-2" : "grid-cols-2"}`}>
                  {opts.map((opt, i) => {
                    const isSelected = selectedAnswerId === opt.id;
                    return (
                      <button
                        key={opt.id}
                        onClick={() => submitHigherLower(opt.id)}
                        disabled={isLocked}
                        className={`${BG[i % BG.length]} ${isSelected ? "ring-4 ring-white scale-95" : ""} ${isLocked && !isSelected ? "opacity-40 cursor-default" : "active:scale-95"} p-4 rounded-xl text-center font-bold transition-all duration-150 ${opts.length <= 4 ? "text-xl py-6" : "text-base py-4"}`}
                      >
                        {opt.name}
                      </button>
                    );
                  })}
                </div>
                {isLocked && (
                  <p className="text-center text-zinc-400 text-sm animate-pulse">Respuesta enviada — esperando a los demás...</p>
                )}
              </>
            );
          })()}

          {/* ── Closest number (opción múltiple con números) ── */}
          {question.question_type === "closest_number" && (() => {
            const opts = (question as any).options as {id: string; label: string}[] ?? [];
            const unit = (question as any).unit ?? "";
            const BG = ["bg-blue-700 hover:bg-blue-600","bg-red-700 hover:bg-red-600","bg-yellow-600 hover:bg-yellow-500","bg-green-700 hover:bg-green-600","bg-purple-700 hover:bg-purple-600","bg-pink-700 hover:bg-pink-600","bg-orange-600 hover:bg-orange-500","bg-teal-700 hover:bg-teal-600","bg-indigo-700 hover:bg-indigo-600","bg-cyan-700 hover:bg-cyan-600"];
            return (
              <>
                {unit && <p className="text-center text-zinc-500 text-sm -mt-2">en {unit}</p>}
                <div className={`grid gap-3 mt-1 ${opts.length <= 4 ? "grid-cols-2" : "grid-cols-2 sm:grid-cols-3"}`}>
                  {opts.map((opt, i) => {
                    const isSelected = selectedAnswerId === opt.id;
                    const isLocked = closestSubmitted;
                    return (
                      <button
                        key={opt.id}
                        onClick={() => submitClosestNumber(opt.id)}
                        disabled={isLocked}
                        className={`${BG[i % BG.length]} ${isSelected ? "ring-4 ring-white scale-95" : ""} ${isLocked && !isSelected ? "opacity-40 cursor-default" : "active:scale-95"} p-5 rounded-xl text-center font-bold text-2xl transition-all duration-150`}
                      >
                        {opt.label}
                      </button>
                    );
                  })}
                </div>
                {closestSubmitted && <p className="text-center text-zinc-400 text-sm animate-pulse">Respuesta enviada — esperando a los demás...</p>}
              </>
            );
          })()}

          {/* ── Ranking order (drag-and-drop) ── */}
          {question.question_type === "ranking_order" && (
            <>
              {question.attribute_name && (
                <p className="text-center text-zinc-500 text-sm -mt-2">
                  Arrastrá para ordenar · {question.attribute_name}{question.unit ? ` (${question.unit})` : ""}
                </p>
              )}
              <div className="flex flex-col gap-2 mt-1 select-none">
                {rankingItems.map((item, idx) => {
                  const medalColors = ["border-yellow-400 bg-yellow-400/10","border-zinc-400 bg-zinc-400/10","border-orange-600 bg-orange-600/10"];
                  const borderCls = medalColors[idx] ?? "border-zinc-700 bg-zinc-800/50";
                  return (
                    <div
                      key={item.id}
                      draggable={!rankingSubmitted}
                      onDragStart={() => { rankingDragIdx.current = idx; }}
                      onDragOver={e => {
                        e.preventDefault();
                        if (rankingDragIdx.current === null || rankingDragIdx.current === idx) return;
                        const next = [...rankingItems];
                        const [moved] = next.splice(rankingDragIdx.current, 1);
                        next.splice(idx, 0, moved);
                        rankingDragIdx.current = idx;
                        setRankingItems(next);
                      }}
                      onDragEnd={() => { rankingDragIdx.current = null; }}
                      className={`flex items-center gap-3 px-3 py-3 rounded-xl border-2 font-medium cursor-grab active:cursor-grabbing transition-all ${borderCls} ${rankingSubmitted ? "opacity-60 cursor-default" : ""}`}
                    >
                      <span className="w-7 h-7 rounded-full bg-zinc-700 text-zinc-300 text-sm font-bold flex items-center justify-center shrink-0">
                        {idx + 1}
                      </span>
                      <span className="flex-1 text-sm">{item.name}</span>
                      {!rankingSubmitted && <span className="text-zinc-600 text-lg">⠿</span>}
                    </div>
                  );
                })}
              </div>
              {!rankingSubmitted ? (
                <button
                  onClick={submitRanking}
                  className="mt-1 bg-green-600 hover:bg-green-500 px-6 py-2 rounded-lg font-bold transition-colors w-full"
                >
                  Confirmar orden ✓
                </button>
              ) : (
                <p className="text-center text-zinc-400 text-sm animate-pulse">Orden enviado — esperando a los demás...</p>
              )}
            </>
          )}

          {/* ── Timeline order ── */}
          {question.question_type === "timeline_order" && (
            <>
              <p className="text-center text-zinc-500 text-sm -mt-2">
                Hacé click en el orden correcto (1 = más antiguo)
              </p>
              <div className="flex flex-col gap-2 mt-1">
                {(question.events ?? []).map((ev) => {
                  const pos = timelineOrder.indexOf(ev.id);
                  const selected = pos !== -1;
                  const isLocked = timelineSubmittedRef.current;
                  return (
                    <button
                      key={ev.id}
                      onClick={() => clickTimelineEvent(ev.id)}
                      disabled={selected || isLocked}
                      className={`
                        flex items-center gap-3 p-3 rounded-lg text-left font-medium transition-all duration-150
                        ${selected ? "bg-green-700 opacity-80 cursor-default" : "bg-zinc-700 hover:bg-zinc-600 active:scale-95"}
                        ${isLocked && !selected ? "opacity-40 cursor-default" : ""}
                      `}
                    >
                      <span className={`w-7 h-7 rounded-full flex items-center justify-center text-sm font-bold shrink-0 ${selected ? "bg-green-500 text-white" : "bg-zinc-600 text-zinc-400"}`}>
                        {selected ? pos + 1 : "?"}
                      </span>
                      {ev.title}
                    </button>
                  );
                })}
              </div>
              {timelineSubmittedRef.current && (
                <p className="text-center text-zinc-400 text-sm animate-pulse">Respuesta enviada — esperando a los demás...</p>
              )}
              {!timelineSubmittedRef.current && timelineOrder.length > 0 && timelineOrder.length < (question.events ?? []).length && (
                <p className="text-center text-zinc-500 text-xs">{timelineOrder.length} de {(question.events ?? []).length} seleccionados</p>
              )}
            </>
          )}
        </div>
      )}

      {/* REVEAL */}
      {phase === "REVEAL" && revealData && question && (
        <div className="flex flex-col gap-4 w-full max-w-xl items-center">

          {/* ── Reveal: multiple choice ── */}
          {(!revealData.question_type || revealData.question_type === "multiple_choice") && (
            <div className="grid grid-cols-2 gap-2 w-full">
              {(question.options as string[]).map((option, index) => {
                const isCorrect = index === revealData.correct_index;
                const wasSelected = selectedAnswer === index;
                return (
                  <div
                    key={index}
                    className={`p-3 rounded-lg text-sm font-medium text-left transition-all animate-zoom-in-fast ${isCorrect ? "bg-green-600 ring-2 ring-green-400 animate-glow-green" : OPTION_COLORS_BASE[index]} ${wasSelected && !isCorrect ? "opacity-40 line-through animate-shake" : ""} ${isCorrect && wasSelected ? "scale-105" : ""}`}
                    style={{ animationDelay: `${index * 80}ms` }}
                  >
                    <span className="font-bold mr-1">{["A","B","C","D"][index]}.</span>{option}
                  </div>
                );
              })}
            </div>
          )}

          {/* ── Reveal: higher_lower ── */}
          {revealData.question_type === "higher_lower" && (
            <div className="w-full flex flex-col gap-3">
              <div className="grid grid-cols-2 gap-3">
                {(revealData.options ?? []).map((opt, i) => {
                  const isCorrect = opt.id === revealData.correct_id;
                  const wasSelected = selectedAnswerId === opt.id;
                  const val = revealData.values?.[opt.id];
                  return (
                    <div key={opt.id} className={`p-4 rounded-xl text-center font-bold transition-all animate-zoom-in-fast ${isCorrect ? "bg-green-600 ring-2 ring-green-400 animate-glow-green" : (i === 0 ? "bg-blue-800" : "bg-red-800")} ${wasSelected && !isCorrect ? "opacity-40 animate-shake" : ""}`}>
                      <div className="text-lg">{opt.name}</div>
                      {val != null && (
                        <div className="text-sm font-normal text-white/80 mt-1">
                          {val.toLocaleString()} {revealData.unit ?? ""}
                        </div>
                      )}
                      {isCorrect && <div className="text-xs mt-1 text-green-200">✓ Correcto</div>}
                    </div>
                  );
                })}
              </div>
            </div>
          )}

          {/* ── Reveal: closest_number ── */}
          {revealData.question_type === "closest_number" && (() => {
            const opts = (revealData as any).options as {id:string; label:string}[] ?? [];
            const correctId = (revealData as any).correct_id ?? "";
            const BG_BASE = ["bg-blue-800","bg-red-800","bg-yellow-700","bg-green-800","bg-purple-800","bg-pink-800","bg-orange-700","bg-teal-800","bg-indigo-800","bg-cyan-800"];
            return (
              <div className={`grid gap-2 w-full ${opts.length <= 4 ? "grid-cols-2" : "grid-cols-2 sm:grid-cols-3"}`}>
                {opts.map((opt, i) => {
                  const isCorrect = opt.id === correctId;
                  const wasSelected = selectedAnswerId === opt.id;
                  return (
                    <div key={opt.id} className={`p-4 rounded-xl text-center font-bold text-2xl transition-all animate-zoom-in-fast ${isCorrect ? "bg-green-600 ring-2 ring-green-400 animate-glow-green" : BG_BASE[i % BG_BASE.length]} ${wasSelected && !isCorrect ? "opacity-40 animate-shake" : ""}`} style={{ animationDelay: `${i * 60}ms` }}>
                      {opt.label}
                      {isCorrect && <div className="text-xs font-normal text-green-200 mt-1">✓ correcto</div>}
                    </div>
                  );
                })}
              </div>
            );
          })()}

          {/* ── Reveal: ranking_order ── */}
          {revealData.question_type === "ranking_order" && (
            <div className="w-full flex flex-col gap-2">
              <p className="text-center text-zinc-400 text-sm font-semibold mb-1">Orden correcto:</p>
              {(revealData.correct_order ?? []).map((id, i) => {
                const name = revealData.correct_order_titles?.[i] ?? id;
                const val = revealData.values?.[id];
                return (
                  <div key={id} className="flex items-center gap-3 bg-blue-800/60 border border-blue-600/40 p-3 rounded-lg animate-zoom-in-fast" style={{ animationDelay: `${i * 100}ms` }}>
                    <span className="w-7 h-7 rounded-full bg-blue-500 text-white text-sm font-bold flex items-center justify-center shrink-0">{i + 1}</span>
                    <span className="text-sm font-medium flex-1">{name}</span>
                    {val != null && (
                      <span className="text-xs text-zinc-400 font-mono">{val.toLocaleString()} {revealData.unit ?? ""}</span>
                    )}
                  </div>
                );
              })}
            </div>
          )}

          {/* ── Reveal: timeline_order ── */}
          {revealData.question_type === "timeline_order" && (
            <div className="w-full flex flex-col gap-2">
              <p className="text-center text-zinc-400 text-sm font-semibold mb-1">Orden correcto:</p>
              {(revealData.correct_order_titles ?? []).map((title, i) => (
                <div key={i} className="flex items-center gap-3 bg-green-800/60 border border-green-600/40 p-3 rounded-lg animate-zoom-in-fast" style={{ animationDelay: `${i * 100}ms` }}>
                  <span className="w-7 h-7 rounded-full bg-green-500 text-white text-sm font-bold flex items-center justify-center shrink-0">{i + 1}</span>
                  <span className="text-sm font-medium">{title}</span>
                </div>
              ))}
            </div>
          )}

          {/* Resultado personal */}
          <div className="flex flex-col items-center gap-1">
            <div className="flex items-center gap-3">
              {(selectedAnswer !== null || selectedAnswerId !== null || timelineSubmittedRef.current) ? (
                <span className={`text-2xl font-bold ${answerAnim === "correct" ? "text-green-400 animate-bounce-correct" : answerAnim === "wrong" ? "text-red-400 animate-shake" : "text-zinc-300"}`}>
                  {answerAnim === "correct" ? "✓ ¡Correcto!" : answerAnim === "wrong" ? "✗ Incorrecto" : "—"}
                </span>
              ) : (
                <span className="text-2xl font-bold text-zinc-500">Sin respuesta</span>
              )}
              {floatingPts != null && floatingPts > 0 && (
                <span className="text-green-300 font-bold text-lg animate-float-score">+{floatingPts}</span>
              )}
            </div>
            <span className="text-zinc-500 text-sm">{revealData.correct_pct}% de jugadores acertó</span>
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
