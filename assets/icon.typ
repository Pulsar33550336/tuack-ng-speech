// Tuack-NG 图标：cetz 画的括号、斜线与三段圆环。
// 复制自 ~/Projects/tuack-ng-design/icon.typ（那套图标/横幅的源文件），未作改动。
// 用在：main.typ 的 config-info 标题，深色标题块上用 ink: white。

#import "@preview/cetz:0.5.2": canvas, draw

#let H = 880                  // 画布边长
#let CENTER = (H / 2, H / 2)

#let tuack-red = rgb("#B21D26")
#let tuack-yellow = rgb("#EFCC6A")
#let tuack-blue = rgb("#1A8CC9")

#let INK-W = 40               // 括号线宽
#let DIAG-W = 20              // 斜线线宽
#let DIAG-HALF = 140          // 斜线半长

// 括号的两条横边。给出下边，上边由对称性得出。
#let BAR-BOT = 170
#let BAR-TOP = H - BAR-BOT

// 括号的圆头端帽。右端是左端绕中心转 180°；这两个点同时是斜线的两端。
#let TIP-L = (312, BAR-TOP)
#let TIP-R = (H - TIP-L.at(0), H - TIP-L.at(1))

// 圆环：三段等长的弧，首段从 RING-START 起，后两段各加转 RING-STEP。
#let RING-R = 180
#let RING-SW = 30
#let RING-SPAN = 97.2deg
#let RING-START = 136deg
#let RING-STEP = 120deg

// 按段序给出。
#let RING-COLORS = (tuack-red, tuack-yellow, tuack-blue)

/// 圆环上的一点。
///
/// - angle (angle): 角度按 y 轴向下为正计算。
///
/// -> coordinate
#let on-ring(angle) = (
  CENTER.at(0) + RING-R * calc.cos(angle),
  CENTER.at(1) - RING-R * calc.sin(angle),
)

/// 斜线的端点。
///
/// - sign (int): `-1` 得到一端，`+1` 得到另一端。
///
/// -> coordinate
#let diag-end(sign) = {
  // 斜线落在两个端帽的连线上，方向由这两点给出。
  let (dx, dy) = (TIP-R.at(0) - TIP-L.at(0), TIP-R.at(1) - TIP-L.at(1))
  let len = calc.sqrt(dx * dx + dy * dy)
  (CENTER.at(0) + sign * DIAG-HALF * dx / len, CENTER.at(1) + sign * DIAG-HALF * dy / len)
}

/// 绘制 Tuack-NG 图标。
///
/// - ink (color): 括号与斜线的颜色。浅底用 `black`，深底用 `white`。
/// - size (length): 画布边长。
#let tuack-icon(ink: black, size: 880pt) = canvas(
  length: size / H,
  padding: 0,
  {
    import draw: *

    // 钉住包围盒，否则 cetz 会按内容自适应缩放。
    rect((0, 0), (H, H), stroke: none, fill: none)

    let left-bracket(ink) = {
      svg-path(
        ("M", (252, BAR-BOT)),
        ("L", (134, BAR-BOT)),
        ("L", (134, 612)),
        ("C", (134, 633), (145, 657.5), (162.25, 676.75)),
        ("C", (179.5, 696), (203, BAR-TOP), (228, BAR-TOP)),
        ("L", TIP-L),
        stroke: (paint: ink, thickness: INK-W, cap: "butt", join: "miter"),
        fill: none,
      )
      circle(TIP-L, radius: INK-W / 2, fill: ink, stroke: none) // 圆头端帽
    }

    left-bracket(ink)
    scope({
      rotate(z: 180deg, origin: CENTER)
      left-bracket(ink)
    })

    line(diag-end(-1), diag-end(1), stroke: (paint: ink, thickness: DIAG-W, cap: "round"))

    for (i, color) in RING-COLORS.enumerate() {
      let start = RING-START + i * RING-STEP
      arc(on-ring(start), start: -start, delta: -RING-SPAN, radius: RING-R, stroke: (
        paint: color,
        thickness: RING-SW,
        cap: "round",
      ))
    }
  },
)

/// 一个变体的图形，不设页面，便于放进表格。
///
/// - ink (color, auto): 括号与斜线的颜色。`auto` 取与背景相反的颜色。
/// - bg (color, none): 背景色，`none` 为无背景。
/// - radius (ratio): 背景圆角占边长的比例，`0%` 即方角。
/// - zoom (ratio): 图形占画布的比例，给头像之类留边。
#let variant(ink: auto, bg: none, radius: 0%, zoom: 100%, size: 220pt) = box(
  width: size,
  height: size,
  {
    let ink = if ink == auto {
      if bg == black { white } else { black }
    } else { ink }
    if bg != none { place(rect(width: size, height: size, radius: size * radius, fill: bg)) }
    place(center + horizon, scale(x: zoom, y: zoom, origin: center, tuack-icon(ink: ink, size: size)))
  },
)
