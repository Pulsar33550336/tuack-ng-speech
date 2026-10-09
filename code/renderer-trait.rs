// tuack-plugin-sdk 里的渲染器契约
pub trait Renderer: Send + Sync {
    fn new() -> Self where Self: Sized;
    fn render(&self, doc: RenderDocument)
        -> Result<(PathBuf, Vec<OutputFile>), Error>;
}

// 实现 trait，再调一个宏注册成 extism 导出函数
renderer!(MyRenderer);
