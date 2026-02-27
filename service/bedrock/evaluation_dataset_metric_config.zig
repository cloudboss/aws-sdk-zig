const EvaluationDataset = @import("evaluation_dataset.zig").EvaluationDataset;
const EvaluationTaskType = @import("evaluation_task_type.zig").EvaluationTaskType;

/// Defines the prompt datasets, built-in metric names and custom metric names,
/// and the task type.
pub const EvaluationDatasetMetricConfig = struct {
    /// Specifies the prompt dataset.
    dataset: EvaluationDataset,

    /// The names of the metrics you want to use for your evaluation job.
    ///
    /// For knowledge base evaluation jobs that evaluate retrieval only, valid
    /// values are "`Builtin.ContextRelevance`", "`Builtin.ContextCoverage`".
    ///
    /// For knowledge base evaluation jobs that evaluate retrieval with response
    /// generation, valid values are "`Builtin.Correctness`",
    /// "`Builtin.Completeness`", "`Builtin.Helpfulness`",
    /// "`Builtin.LogicalCoherence`", "`Builtin.Faithfulness`",
    /// "`Builtin.Harmfulness`", "`Builtin.Stereotyping`", "`Builtin.Refusal`".
    ///
    /// For automated model evaluation jobs, valid values are "`Builtin.Accuracy`",
    /// "`Builtin.Robustness`", and "`Builtin.Toxicity`". In model evaluation jobs
    /// that use a LLM as judge you can specify "`Builtin.Correctness`",
    /// "`Builtin.Completeness"`, "`Builtin.Faithfulness"`, "`Builtin.Helpfulness`",
    /// "`Builtin.Coherence`", "`Builtin.Relevance`",
    /// "`Builtin.FollowingInstructions`", "`Builtin.ProfessionalStyleAndTone`", You
    /// can also specify the following responsible AI related metrics only for model
    /// evaluation job that use a LLM as judge "`Builtin.Harmfulness`",
    /// "`Builtin.Stereotyping`", and "`Builtin.Refusal`".
    ///
    /// For human-based model evaluation jobs, the list of strings must match the
    /// `name` parameter specified in `HumanEvaluationCustomMetric`.
    metric_names: []const []const u8,

    /// The the type of task you want to evaluate for your evaluation job. This
    /// applies only to model evaluation jobs and is ignored for knowledge base
    /// evaluation jobs.
    task_type: EvaluationTaskType,

    pub const json_field_names = .{
        .dataset = "dataset",
        .metric_names = "metricNames",
        .task_type = "taskType",
    };
};
