/// Describes an Lambda data source configuration.
pub const LambdaDataSourceConfig = struct {
    /// The Amazon Resource Name (ARN) for the Lambda function.
    lambda_function_arn: []const u8,

    pub const json_field_names = .{
        .lambda_function_arn = "lambdaFunctionArn",
    };
};
