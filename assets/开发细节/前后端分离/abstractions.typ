// 抽象地图：每个方框是一个 trait，箭头是它管的动作。
// 用在：== 前后端分离，由 main.typ 里 #include 引入。
#import "@preview/fletcher:0.5.8": diagram, edge, node

#text(size: 12pt)[
  #diagram(
    node-stroke: 0.7pt,
    node-corner-radius: 4pt,
    node-inset: 7pt,
    edge-stroke: 0.9pt,
    spacing: (34pt, 34pt),
    node((0, 0), [`Document`], name: <doc>, fill: rgb("#fef7f7")),
    node((1.2, 0), [`RenProcessor`], name: <proc>, fill: rgb("#fef7f7")),
    node((2.4, 0), [`Renderer` / `Dumper`], name: <ren>, fill: rgb("#fef7f7")),
    edge(<doc.east>, <proc.west>, "->", [改写]),
    edge(<proc.east>, <ren.west>, "->", [渲染 / 导出]),
    node((0, 1.4), [`Generator`], name: <gen>, fill: rgb("#fef7f7")),
    node((1.2, 1.4), [`Validator`], name: <val>, fill: rgb("#fef7f7")),
    node((2.4, 1.4), [`Data` + `Runner`], name: <run>, fill: rgb("#fef7f7")),
    edge(<gen.east>, <val.west>, "->", [生成输入与答案]),
    edge(<val.east>, <run.west>, "->", [校验 · 搬运 · 执行]),
    node((0, 2.8), [`AssetProvider`], name: <asset>, fill: rgb("#eef6ee")),
    node((1.6, 2.8), [上面每一步要读的文件，都由它按题号惰性取], stroke: none, fill: none),
    edge(<asset.east>, (1.5, 2.8), "->"),
  )
]
