/// Configuration details for an AWS Lambda function used as an endpoint for a
/// cloud connector.
pub const LambdaConfig = struct {
    /// The Amazon Resource Name (ARN) of the Lambda function used as an endpoint.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
    };
};
