// 插件的信任生命周期：安装 → 未信任 →（trust）→ 已加载，以及取消信任的回边。
// 状态由包目录里的空文件决定（.trusted 允许加载，.disabled 直接停用），只由宿主写。
// 回边走下方的折线（vertices + corner-radius），避免压住节点。
// 用在：== 插件 - 信任模型，由 main.typ 里 #include 引入。
#import "@preview/fletcher:0.5.8": diagram, edge, node

#let W = rgb("#fff4d6")  // 不加载
#let G = rgb("#eef6ee")  // 已加载
#let B = rgb("#eaf2fb")  // 宿主操作

#figure(caption: [插件的信任生命周期], numbering: none)[
  #text(size: 18pt)[
    #diagram(
      node-stroke: 0.7pt,
      node-corner-radius: 4pt,
      node-inset: 6pt,
      edge-stroke: 1pt,
      spacing: (170pt, 34pt),

      node((0, 0), [安装插件], fill: B, name: <inst>, shape: rect),
      node((1.05, 0), [未信任\ 不加载], fill: W, name: <un>, shape: rect),
      node((2.1, 0), [已加载\ 可用], fill: G, name: <ok>, shape: rect),

      edge(<inst.east>, <un.west>, "->"),
      edge(<un.east>, <ok.west>, "->", [用户手动信任]),
      edge(
        <ok.south>,
        (2.1, 1.4),
        (1.05, 1.4),
        <un.south>,
        "->",
        corner-radius: 5pt,
        label: [用户取消信任 / 插件更新],
        label-pos: (1, 50%),
      ),
    )
  ]
]
