const Payload = @import("payload.zig").Payload;

/// Calls a Lambda function, passing in information about the detector model
/// instance and the
/// event that triggered the action.
pub const LambdaAction = struct {
    /// The ARN of the Lambda function that is executed.
    function_arn: []const u8,

    /// You can configure the action payload when you send a message to a Lambda
    /// function.
    payload: ?Payload,

    pub const json_field_names = .{
        .function_arn = "functionArn",
        .payload = "payload",
    };
};
