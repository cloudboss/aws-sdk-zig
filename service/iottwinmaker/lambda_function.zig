/// The Lambda function.
pub const LambdaFunction = struct {
    /// The ARN of the Lambda function.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
    };
};
