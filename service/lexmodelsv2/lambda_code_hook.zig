/// Specifies a Lambda function that verifies requests to a bot or
/// fulfills the user's request to a bot.
pub const LambdaCodeHook = struct {
    /// The version of the request-response that you want Amazon Lex to use to
    /// invoke your Lambda function.
    code_hook_interface_version: []const u8,

    /// The Amazon Resource Name (ARN) of the Lambda function.
    lambda_arn: []const u8,

    pub const json_field_names = .{
        .code_hook_interface_version = "codeHookInterfaceVersion",
        .lambda_arn = "lambdaARN",
    };
};
