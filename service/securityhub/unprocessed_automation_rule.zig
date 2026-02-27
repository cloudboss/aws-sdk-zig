/// A list of objects containing `RuleArn`, `ErrorCode`, and `ErrorMessage`.
/// This parameter
/// tells you which automation rules the request didn't process and why.
pub const UnprocessedAutomationRule = struct {
    /// The error code associated with the unprocessed automation rule.
    error_code: ?i32,

    /// An error message describing why a request didn't process a specific rule.
    error_message: ?[]const u8,

    /// The Amazon Resource Name (ARN) for the unprocessed automation rule.
    rule_arn: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .rule_arn = "RuleArn",
    };
};
