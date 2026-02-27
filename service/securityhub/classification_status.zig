/// Provides details about the current status of the sensitive data detection.
pub const ClassificationStatus = struct {
    /// The code that represents the status of the sensitive data detection.
    code: ?[]const u8,

    /// A longer description of the current status of the sensitive data detection.
    reason: ?[]const u8,

    pub const json_field_names = .{
        .code = "Code",
        .reason = "Reason",
    };
};
