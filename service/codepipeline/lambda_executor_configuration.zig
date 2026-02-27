/// Details about the configuration for the `Lambda` action engine, or
/// executor.
pub const LambdaExecutorConfiguration = struct {
    /// The ARN of the Lambda function used by the action engine.
    lambda_function_arn: []const u8,

    pub const json_field_names = .{
        .lambda_function_arn = "lambdaFunctionArn",
    };
};
