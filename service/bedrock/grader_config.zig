const LambdaGraderConfig = @import("lambda_grader_config.zig").LambdaGraderConfig;

/// Configuration for the grader used in reinforcement fine-tuning to evaluate
/// model responses and provide reward signals.
pub const GraderConfig = union(enum) {
    /// Configuration for using an AWS Lambda function as the grader for evaluating
    /// model responses and provide reward signals in reinforcement fine-tuning.
    lambda_grader: ?LambdaGraderConfig,

    pub const json_field_names = .{
        .lambda_grader = "lambdaGrader",
    };
};
