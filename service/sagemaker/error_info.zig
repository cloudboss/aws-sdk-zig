/// This is an error field object that contains the error code and the reason
/// for an operation failure.
pub const ErrorInfo = struct {
    /// The error code for an invalid or failed operation.
    code: ?[]const u8 = null,

    /// The failure reason for the operation.
    reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .reason = "Reason",
    };
};
