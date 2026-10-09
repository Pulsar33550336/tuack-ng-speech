//! 把一份题面 Markdown 解析成 AST 并打印（幻灯片「题面 - 一切皆 AST」那页用的就是它）。
//!
//! cargo run --quiet > ast-cnoi.txt      # Rust 的 {:#?} 形式
//! cargo run --quiet -- json > ast-cnoi.json

use tuack_ng_parser::parse;

const SRC: &str = include_str!("../../../assets/功能一览/题面-语法/cnoi-syntax.md");

fn main() {
    let doc = parse(SRC);
    if std::env::args().nth(1).as_deref() == Some("json") {
        println!("{}", serde_json::to_string_pretty(&doc).unwrap());
    } else {
        println!("{doc:#?}");
    }
}
