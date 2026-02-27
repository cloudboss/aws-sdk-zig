/// Error for batch describe case rules API failure. In the Amazon Connect admin
/// website, case rules are known as *case field conditions*. For more
/// information about case field conditions, see [Add case field conditions to a
/// case
/// template](https://docs.aws.amazon.com/connect/latest/adminguide/case-field-conditions.html).
pub const CaseRuleError = struct {
    /// Error code from getting a case rule.
    error_code: []const u8,

    /// The case rule identifier that caused the error.
    id: []const u8,

    /// Error message from getting a case rule.
    message: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .id = "id",
        .message = "message",
    };
};
