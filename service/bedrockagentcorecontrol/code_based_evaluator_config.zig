const LambdaEvaluatorConfig = @import("lambda_evaluator_config.zig").LambdaEvaluatorConfig;

/// Configuration for a code-based evaluator. Specify the Lambda function to use
/// for evaluation.
pub const CodeBasedEvaluatorConfig = union(enum) {
    /// The Lambda function configuration for code-based evaluation.
    lambda_config: ?LambdaEvaluatorConfig,

    pub const json_field_names = .{
        .lambda_config = "lambdaConfig",
    };
};
