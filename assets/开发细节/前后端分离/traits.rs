/// 渲染器：把 RenderDocument 渲染成产物文件。
pub trait Renderer: Send + Sync {
    fn render(&self, doc: &RenderDocument, assets: Box<dyn AssetProvider>)
        -> Result<(PathBuf, Vec<OutputFile>)>;
}

/// 导出器：与 Renderer 同构，输入换成 DumpDocument。
pub trait Dumper: Send + Sync {
    fn dump(&self, doc: &DumpDocument, assets: Box<dyn AssetProvider>)
        -> Result<(Vec<OutputFile>, Vec<String>)>;
}
