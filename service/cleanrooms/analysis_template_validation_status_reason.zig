/// The reasons for the validation results.
pub const AnalysisTemplateValidationStatusReason = struct {
    /// The validation message.
    message: []const u8,

    pub const json_field_names = .{
        .message = "message",
    };
};
