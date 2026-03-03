/// Sampling statistics from a call to
/// [GetSamplingTargets](https://docs.aws.amazon.com/xray/latest/api/API_GetSamplingTargets.html) that X-Ray
/// could not process.
pub const UnprocessedStatistics = struct {
    /// The error code.
    error_code: ?[]const u8 = null,

    /// The error message.
    message: ?[]const u8 = null,

    /// The name of the sampling rule.
    rule_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .message = "Message",
        .rule_name = "RuleName",
    };
};
