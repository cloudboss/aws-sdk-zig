/// Configuration for a Lambda function used as a code-based evaluator.
pub const LambdaEvaluatorConfig = struct {
    /// The Amazon Resource Name (ARN) of the Lambda function that implements the
    /// evaluation logic.
    lambda_arn: []const u8,

    /// The timeout in seconds for the Lambda function invocation. Defaults to 60.
    /// Must be between 1 and 300.
    lambda_timeout_in_seconds: ?i32 = null,

    pub const json_field_names = .{
        .lambda_arn = "lambdaArn",
        .lambda_timeout_in_seconds = "lambdaTimeoutInSeconds",
    };
};
