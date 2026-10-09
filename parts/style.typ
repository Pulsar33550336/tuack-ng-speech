// 全篇共用的调色板与排版 helper，各页都会 import。
#import "@preview/xwysyy:0.4.0": *

// 分节线
#let sep = line(length: 100%)

// 讲者备注（走 Touying 的 speaker-note）
#let script(it) = speaker-note[
  #set text(size: 18pt)
  #it
]

// 等宽高亮小块的默认字号与行高
#let MCODE = 9pt
#let MLH = 10pt
// 等宽文本
#let mono(s, size: MCODE) = text(font: "Maple Mono Normal NL NF", size: size, s)
// 带底色的等宽小块：色块与行内高亮都用它
#let band(c, s, size: MCODE, lh: MLH, inset: (x: 0.3em), radius: 0.3em) = box(
  fill: c,
  inset: inset,
  radius: radius,
  height: 1.02 * lh,
  align(horizon, mono(s, size: size)),
)
// 调色板：14 个通用色，随便取用，没有固定含义。
#let mcolors = (
  m1: rgb("#9ec9f5"),   // 天蓝
  m2: rgb("#ffd166"),   // 琥珀
  m3: rgb("#9ee493"),   // 嫩绿
  m4: rgb("#f7a8c4"),   // 粉
  m5: rgb("#c3aaf0"),   // 淡紫
  m6: rgb("#7fd4cf"),   // 青
  m7: rgb("#ffcf9c"),   // 杏
  m8: rgb("#cfe8a9"),   // 草绿
  m9: rgb("#d9c2f0"),   // 藕荷
  m10: rgb("#e8a4a4"),  // 红
  m11: rgb("#a8c4e0"),  // 钢蓝
  m12: rgb("#d8c48c"),  // 沙金
  m13: rgb("#9fd0b8"),  // 薄荷
  m14: rgb("#c0a8d8"),  // 紫
)

// 迷你标注：把 <m3>…</m3> 包住的部分上色，其余按等宽正文。
// 长常量用它比一个个 band()/mono() 拼起来好写：
//   mspan("<m7>kind: </m7><m14>\"figure\"</m14>")
#let mspan(src, size: MCODE, lh: MLH) = {
  let cs = src.clusters()
  let n = cs.len()
  let out = ()
  let buf = ""
  let col = none
  let i = 0
  while i < n {
    if cs.at(i) == "<" and i + 1 < n and cs.at(i + 1) == "<" {
      buf += "<"
      i += 2
    } else if cs.at(i) == "<" {
      let j = i + 1
      while j < n and cs.at(j) != ">" { j += 1 }
      let tag = cs.slice(i + 1, j).join()
      if buf != "" {
        out.push(
          if col == none { mono(buf, size: size) }
          // 全是空格的标签算缩进色条：不要左右内边距，宽度正好是那几个空格
          else if buf.trim() == "" { band(mcolors.at(col), buf, size: size, lh: lh, inset: 0pt, radius: 0.25em) }
          else { band(mcolors.at(col), buf, size: size, lh: lh) },
        )
        buf = ""
      }
      col = if tag.starts-with("/") { none } else { tag }
      i = j + 1
    } else {
      buf += cs.at(i)
      i += 1
    }
  }
  if buf != "" {
    out.push(
          if col == none { mono(buf, size: size) }
          // 全是空格的标签算缩进色条：不要左右内边距，宽度正好是那几个空格
          else if buf.trim() == "" { band(mcolors.at(col), buf, size: size, lh: lh, inset: 0pt, radius: 0.25em) }
          else { band(mcolors.at(col), buf, size: size, lh: lh) },
        )
  }
  out.join()
}

// 标注文本的整块版本：直接写一段多行文本，每行都过 mspan，空行就是空行。
// 于是长常量可以整个写成一段字符串，不用再摆成数组。
#let mtext(src, size: MCODE, lh: MLH) = {
  // 只剥掉开头的换行（字符串从 " 的下一行开始写），结尾的换行算一个空行
  let s = if src.starts-with("\n") { src.slice(1) } else { src }
  s.split("\n").map(l => if l == "" { [] } else { mspan(l, size: size, lh: lh) })
}

// 只要字符串数组、不要渲染时用它（cblock 这类按行吃的接口）
#let str-lines(src) = src.trim().split("\n")


// 代码面板外观（模板系统 / 外置表格 / Markdown 导出共用）
#let panel(body, inset: (x: 10pt, y: 4pt)) = block(
  fill: skyll,
  inset: inset,
  radius: 3pt,
  width: 100%,
  body,
)

// 代码面板：统一走主题的 block raw。
// 主题把它压到 0.9em，所以这里按「实际字号」书写，由 helper 换算。
#let code(body, size: 11pt) = text(size: size / 0.9, body)

// 逐行排布：一行一个等高盒子；mcol 把它们整体装进面板
#let mrow(body, lh: MLH) = box(height: lh, align(left + horizon, body))
#let mcol(items, size: MCODE, lh: MLH) = panel({
  set text(size: size)
  set par(leading: 0pt)
  items.map(i => mrow(i, lh: lh)).join(linebreak())
})

// 把一整个文件按行渲染成代码面板，可指定高亮行 hl 与行末批注 note
#let cblock(lines, size: 13pt, lang: none, leading: 0.3em, hl: -1, note: none) = panel(inset: (x: 10pt, y: 7pt), {
  set text(font: "Maple Mono Normal NL NF", size: size)
  set par(leading: leading, justify: false)
  let body = lines
    .enumerate()
    .map(((i, l)) => {
      let r = raw(l, lang: lang)
      if i == hl { highlight(fill: rgb("#ffe08a"), extent: 3pt, radius: 2pt, r) } else { r }
    })
    .join(linebreak())
  if note == none {
    body
  } else {
    // 备注放整个代码块的右下角
    grid(
      columns: (1fr, auto),
      column-gutter: 10pt,
      align: (left + bottom, right + bottom),
      body, raw(note, lang: lang),
    )
  }
})

// 原生注音：小字压在基文上方，不撑行高。用法 #ruby[上方小字][基文]
#let ruby(rt, rb) = context {
  let w = measure(rb).width
  box(width: w)[
    #place(top + center, dy: -0.82em, text(size: 0.7em, rt))
    #rb
  ]
}
#let src-text(s) = mtext(s, size: 11pt, lh: 14pt)
