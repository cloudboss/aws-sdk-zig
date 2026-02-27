/// A Lambda function that processes documents.
pub const TransformationLambdaConfiguration = struct {
    /// The function's ARN identifier.
    lambda_arn: []const u8,

    pub const json_field_names = .{
        .lambda_arn = "lambdaArn",
    };
};
