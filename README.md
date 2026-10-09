# Tuack-NG：功能与设计分享

一份介绍 [Tuack-NG](https://github.com/tuackng/tuack-ng) 的讲稿——它能做什么，以及为什么这样设计。
用 [Typst](https://typst.app/) 与 [Touying](https://touying-typ.github.io/) 写成。

## 构建

```bash
typst compile main.typ
```

排版草稿与编译产物（`preview/`、`main.pdf`）已在 `.gitignore` 中忽略。

## 目录

| 路径               | 内容                                                                |
| ------------------ | ------------------------------------------------------------------- |
| `main.typ`         | 幻灯片正文。按 `=` / `==` 标题分节，`---` 翻页                      |
| `assets/`          | 素材与样式。子目录层级镜像标题层级，如 `assets/功能一览/题面-语法/` |
| `assets/style.typ` | 全篇公用的配色与排版助手（`mspan`、`mtext`、`code`、`panel` 等）    |
| `assets/icon.typ`  | 封面上的 Tuack-NG 图标，用 cetz 绘制                                |
| `tools/ast-dump/`  | 生成「一切皆 AST」那页素材的小工具（Rust）                          |

## 依赖

Typst 包，首次编译会自动下载：`xwysyy:0.4.0`、`cuti:0.4.0`、`fletcher:0.5.8`、`cetz:0.5.2`。

字体需自行安装：正文 `LXGW WenKai`、代码 `Maple Mono Normal NL NF`、末页标题 `Noto Serif`。

## 许可

| 范围                                            | 许可证                               |
| ----------------------------------------------- | ------------------------------------ |
| 代码：`main.typ`、`assets/**/*.typ`、`tools/**` | [MIT](LICENSE-MIT)                   |
| 幻灯片内容：正文文字与图片                      | [CC BY-SA 4.0](LICENSE-CC-BY-SA-4.0) |

由本项目或系列项目生成的文字与图片按 CC 授权，其余素材参考各自协议。

## 第三方

- 题面渲染截图中的 NOIP 题面来自 CCF，以 CC BY-NC 授权（`assets/功能一览/题面-渲染/cover-noi-top.png`）。
- `assets/开发细节/插件-WASM/sdk-plugin.rs` 摘自示例插件仓库 `tuack-ng-plugin-example`，
  以 MIT 授权，Copyright (c) 2026 Tuack-NG Developers。
- 字体各自适用 SIL Open Font License 1.1；本仓库不随附字体文件（`main.pdf` 中按 OFL 允许的方式嵌入）。
- 讲稿讨论的 Tuack-NG 项目本身以 AGPL-3.0 授权；文中引用的命令行输出与截图仅作说明之用。
- cetz 以 LGPL-3.0 授权，作为构建期依赖由 `assets/icon.typ` 引用，其源码不在本仓库中。
