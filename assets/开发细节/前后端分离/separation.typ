// 前后端分离的交接图：两侧各自可插拔，中间那份文档既是契约也是边界。
// 用在：== 前后端分离，由 main.typ 里 #include 引入。
#import "@preview/fletcher:0.5.8": diagram, edge, node

#text(size: 11.5pt)[
  #diagram(
    node-stroke: 0.7pt,
    node-corner-radius: 4pt,
    node-inset: 6pt,
    edge-stroke: 0.9pt,
    spacing: (30pt, 20pt),
    node((0, 0), [题面源／模板], name: <src>, fill: rgb("#eaf2fb")),
    node((1.5, 0), [数据与配置], name: <cfg>, fill: rgb("#eaf2fb")),
    node((0.75, 1), [*前端*], name: <front>),
    edge(<src.south>, <front.north>, "->"),
    edge(<cfg.south>, <front.north>, "->"),
    node((0.75, 2), [RenderDocument ／ DumpDocument], name: <doc>,
         stroke: 1.4pt + rgb("#e8a4a4"), fill: rgb("#fef7f7")),
    edge(<front.south>, <doc.north>, "->", [不可变、可序列化]),
    node((0.75, 3), [*后端*], name: <back>),
    edge(<doc.south>, <back.north>, "->"),
    node((0, 4), [PDF ／ Markdown], name: <o1>, fill: rgb("#eef6ee")),
    node((1.5, 4), [Lemon ／ Arbiter ／ CCR], name: <o2>, fill: rgb("#eef6ee")),
    edge(<back.south>, <o1.north>, "->"),
    edge(<back.south>, <o2.north>, "->"),
    node((1.9, 1), [只管内容], stroke: none, fill: none),
    node((1.9, 3), [只管长什么样], stroke: none, fill: none),
  )
]
