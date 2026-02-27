/// Describes an action to invoke a Lambda function.
pub const LambdaAction = struct {
    /// The ARN of the Lambda function.
    function_arn: []const u8,

    pub const json_field_names = .{
        .function_arn = "functionArn",
    };
};
