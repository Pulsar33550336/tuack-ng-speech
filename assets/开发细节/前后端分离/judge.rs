// ── 后端　crates/tuack-lib/src/test.rs ──

impl TestSession {
    /// 评测单个测试点：构造本次运行的输入 -> 执行 -> 校验 -> 返回结果
    ///
    /// 读输入/答案失败、超时超内存、非零退出、未产出输出与校验失败都归一化为
    /// TestCaseResult（如 UKE、FE），不表现为 Err。
    pub fn judge(&mut self, data: &dyn Data) -> Result<TestCaseResult> { .. }
}

// ── 前端　crates/tuack-ng/src/test/policy.rs ──

/// 判分策略：解释一组执行结果，并返回 ScoreReport。
pub trait ScorePolicy {
    fn score(&self, config: &ProblemConfig, data_items: &[FsTestData],
             results: &[TestCaseResult]) -> ScoreReport;
}

/// 正式数据判分：分组与计分模型取自 config.runtime.subtasks
pub struct DataPolicy;
/// 样例判分：单独一组 {0: Sum}
pub struct SamplePolicy;
