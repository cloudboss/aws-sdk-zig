const AutomatedEvaluationConfig = @import("automated_evaluation_config.zig").AutomatedEvaluationConfig;
const HumanEvaluationConfig = @import("human_evaluation_config.zig").HumanEvaluationConfig;

/// The configuration details of either an automated or human-based evaluation
/// job.
pub const EvaluationConfig = union(enum) {
    /// Contains the configuration details of an automated evaluation job that
    /// computes metrics.
    automated: ?AutomatedEvaluationConfig,
    /// Contains the configuration details of an evaluation job that uses human
    /// workers.
    human: ?HumanEvaluationConfig,

    pub const json_field_names = .{
        .automated = "automated",
        .human = "human",
    };
};
