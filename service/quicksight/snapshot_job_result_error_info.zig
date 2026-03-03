/// Information on the error that caused the snapshot job to fail.
pub const SnapshotJobResultErrorInfo = struct {
    /// The error message.
    error_message: ?[]const u8 = null,

    /// The error type.
    error_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_message = "ErrorMessage",
        .error_type = "ErrorType",
    };
};
