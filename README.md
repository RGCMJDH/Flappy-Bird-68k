# 🐦 Flappy Bird 68000

Versión de **Flappy Bird** programada íntegramente en **ensamblador del Motorola 68000** con el simulador **EASy68K**.

Práctica final de la asignatura **Estructura de Computadores II** del Grado en Ingeniería Informática de la **Universitat de les Illes Balears (UIB)**.

---

## 🎮 Cómo jugar

| Acción | Control |
|---|---|
| Empezar la partida | `ESPACIO` |
| Saltar / aletear | `ESPACIO` |
| Pausar / reanudar | `P` |
| Volver a jugar (pantalla de *Game Over*) | Clic en el botón **CLICK HERE TO CONTINUE** |

Tienes que pasar el pájaro entre las tuberías sin chocar con ellas ni con el suelo. Cada tubería superada suma un punto.

---

## ✨ Características

- **Física del pájaro**: gravedad, velocidad máxima de caída e impulso de salto configurables.
- **Tuberías generadas aleatoriamente**: la altura del hueco sale de un generador de números pseudoaleatorios (`LIB/UTLCODE.X68`).
- **Fondo animado** con nubes en *scroll* continuo.
- **Detección de colisiones** contra las tuberías y el suelo.
- **Marcador** en pantalla durante la partida.
- **Máquina de estados** (juego ↔ *game over*) con tablas de saltos para *init*, *update* y *plot*.
- **Doble buffer** y refresco de pantalla sincronizado mediante **interrupciones de temporizador** (50 FPS).
- **Pausa** en cualquier momento de la partida.

### Elementos añadidos

- 💾 **Uso de ficheros**: la puntuación máxima se guarda en `SCORE/score.bin` y se mantiene entre partidas.
- 🖱️ **Uso del ratón**: en la pantalla de *Game Over* hay que pulsar un botón para reiniciar.
- 🖼️ **Visualización de imágenes**: al perder aparece una calavera de 40×40 píxeles.
- 🔊 **Sonido**: efectos de salto y música (`SND/`).

---

## ▶️ Cómo ejecutarlo

1. Instala **[EASy68K](http://www.easy68k.com/)** (solo Windows; en Linux o macOS funciona con Wine).
2. Clona el repositorio:
   ```bash
   git clone https://github.com/RGCMJDH/Flappy-Bird-68k.git
   ```
3. Abre `MAIN.X68` con el editor de EASy68K.
4. Ensambla el programa (**Project → Assemble Source** o `F9`).
5. En la ventana que aparece, pulsa **Execute** para abrir el simulador **Sim68K**.
6. Pulsa **Run** (`F9`) y aparecerá la ventana del juego.

> ⚠️ Ejecútalo siempre desde la carpeta del repositorio. Los sonidos (`SND/`) y el fichero de puntuaciones (`SCORE/score.bin`) se cargan con rutas relativas.

---

## 📁 Estructura del proyecto

```
Flappy-Bird-68k/
├── MAIN.X68          # Punto de entrada y bucle principal (update → sync → plot)
├── SYSTEM.X68        # Inicialización de pantalla, teclado, sonido, interrupciones y traps
├── SYSCONST.X68      # Constantes del sistema (teclas, resolución, traps)
├── SYSVAR.X68        # Variables del sistema (teclado, contadores de interrupción)
├── CONST.X68         # Constantes del juego (física, tuberías, colores, botones…)
├── VARS.X68          # Variables del juego (pájaro, tuberías, puntuación, estado)
├── STATES.X68        # Gestor de estados (juego / game over)
├── GAME.X68          # Lógica del estado de juego, pausa y pantalla de título
├── BIRD.X68          # Movimiento, salto, colisiones y dibujo del pájaro
├── PIPE.X68          # Generación, desplazamiento, colisiones y dibujo de las tuberías
├── BACKGROUND.X68    # Fondo con cielo y nubes en movimiento
├── SCORE.X68         # Cálculo y dibujo del marcador
├── GOVER.X68         # Pantalla de Game Over, récord en fichero y botón con ratón
├── IMAGE.X68         # Rutina para dibujar la imagen de la calavera
├── IMGDATA.X68       # Datos de píxeles de la imagen (40×40)
├── SOUND.X68
├── LIB/              # Librerías de apoyo (utilidades, memoria dinámica, gráficos)
├── SND/              # Efectos de sonido y música (.wav)
└── SCORE/            # Fichero binario con la puntuación máxima
```

---

## 🛠️ Conceptos aplicados

- Programación en ensamblador del **Motorola 68000**.
- **Traps** propios (teclado, refresco de pantalla y sonido) y `TRAP #15` del simulador.
- **Interrupciones** con auto-IRQ para controlar el ritmo de fotogramas.
- **Modo supervisor / modo usuario**.
- **Doble buffer** gráfico para evitar parpadeos.
- Lectura del teclado con detección de flanco (*edge detection*).
- Entrada/salida de **ficheros** y lectura del **ratón**.

---

## 👥 Autores

- **Toni Fuentes**
- **Alberto Gallego**

Universitat de les Illes Balears · Estructura de Computadores II
