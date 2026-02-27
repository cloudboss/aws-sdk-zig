/// Specifies a Lambda function that verifies requests to a bot or
/// fulfills the user's request to a bot..
pub const CodeHook = struct {
    /// The version of the request-response that you want Amazon Lex to use to
    /// invoke your Lambda function. For more information, see using-lambda.
    message_version: []const u8,

    /// The Amazon Resource Name (ARN) of the Lambda function.
    uri: []const u8,

    pub const json_field_names = .{
        .message_version = "messageVersion",
        .uri = "uri",
    };
};
