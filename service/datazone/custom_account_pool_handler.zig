/// The custom Amazon Web Services Lambda handler within an account pool.
pub const CustomAccountPoolHandler = struct {
    /// The ARN of the IAM role that enables Amazon SageMaker Unified Studio to
    /// invoke the Amazon Web Services Lambda funtion if the account source is the
    /// custom account pool handler.
    lambda_execution_role_arn: ?[]const u8,

    /// The ARN of the Amazon Web Services Lambda function for the custom Amazon Web
    /// Services Lambda handler.
    lambda_function_arn: []const u8,

    pub const json_field_names = .{
        .lambda_execution_role_arn = "lambdaExecutionRoleArn",
        .lambda_function_arn = "lambdaFunctionArn",
    };
};
