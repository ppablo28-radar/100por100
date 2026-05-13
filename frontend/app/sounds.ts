// Web Audio API — no requiere archivos externos ni librerías
let ctx: AudioContext | null = null;

function getCtx(): AudioContext | null {
  if (typeof window === "undefined") return null;
  try {
    if (!ctx) ctx = new (window.AudioContext || (window as any).webkitAudioContext)();
    if (ctx.state === "suspended") ctx.resume();
    return ctx;
  } catch {
    return null;
  }
}

function tone(
  freq: number,
  duration: number,
  type: OscillatorType = "sine",
  vol = 0.35,
  delay = 0
) {
  const c = getCtx();
  if (!c) return;
  try {
    const osc = c.createOscillator();
    const gain = c.createGain();
    osc.connect(gain);
    gain.connect(c.destination);
    osc.type = type;
    osc.frequency.value = freq;
    const t = c.currentTime + delay;
    gain.gain.setValueAtTime(vol, t);
    gain.gain.exponentialRampToValueAtTime(0.001, t + duration);
    osc.start(t);
    osc.stop(t + duration + 0.01);
  } catch {}
}

export function soundCorrect() {
  tone(523, 0.08, "sine", 0.4);
  tone(659, 0.08, "sine", 0.4, 0.09);
  tone(784, 0.22, "sine", 0.4, 0.18);
}

export function soundIncorrect() {
  tone(220, 0.15, "sawtooth", 0.3);
  tone(175, 0.28, "sawtooth", 0.2, 0.14);
}

export function soundCountdownBeep() {
  tone(880, 0.07, "square", 0.15);
}

export function soundGameStart() {
  [523, 659, 784, 1047].forEach((f, i) => tone(f, 0.15, "sine", 0.38, i * 0.12));
}

export function soundReveal() {
  tone(440, 0.05, "sine", 0.18);
  tone(660, 0.12, "sine", 0.22, 0.06);
}

export function soundEpic() {
  // ¡Solo vos acertaste!
  [523, 784, 1047, 1319, 1568].forEach((f, i) =>
    tone(f, 0.18, "sine", 0.45, i * 0.09)
  );
}

export function soundStreak() {
  // Racha de correctas
  [659, 784, 988, 1047].forEach((f, i) =>
    tone(f, 0.1, "sine", 0.38, i * 0.07)
  );
}

export function soundGameOver() {
  [784, 659, 523, 392].forEach((f, i) =>
    tone(f, 0.18, "sine", 0.3, i * 0.13)
  );
}

// Inicializa el contexto de audio en el primer click del usuario
export function initAudio() {
  getCtx();
}
