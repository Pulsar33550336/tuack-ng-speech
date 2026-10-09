/// 渲染文档：Renderer 的输入。
/// 不可变、可序列化——要跨 WASM 边界。
pub struct RenderDocument {
    pub config: RenConfig,       // 比赛级元信息
    pub problems: Vec<Problem>,  // 每道题
    pub precaution: Option<Document>,
}

pub struct Problem {
    pub idx: u64,
    pub meta: ProblemMeta,   // 时空限制、文件名、子任务……
    pub ast: Document,       // 题面已经是树，不是文本
    pub images: IndexMap<PathBuf, PathBuf>,
}
