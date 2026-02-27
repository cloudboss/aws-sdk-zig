/// Provide additional context about the status of a command execution using a
/// reason code
/// and description.
pub const StatusReason = struct {
    /// A code that provides additional context for the command execution status.
    reason_code: []const u8,

    /// A literal string for devices to optionally provide additional information
    /// about the
    /// reason code for a command execution status.
    reason_description: ?[]const u8,

    pub const json_field_names = .{
        .reason_code = "reasonCode",
        .reason_description = "reasonDescription",
    };
};
