/// A suggested fix for a vulnerability in your Lambda function code.
pub const SuggestedFix = struct {
    /// The fix's code.
    code: ?[]const u8,

    /// The fix's description.
    description: ?[]const u8,

    pub const json_field_names = .{
        .code = "code",
        .description = "description",
    };
};
