/// Information on the error that caused the snapshot job to fail.
pub const SnapshotJobResultErrorInfo = struct {
    /// The error message.
    error_message: ?[]const u8,

    /// The error type.
    error_type: ?[]const u8,

    pub const json_field_names = .{
        .error_message = "ErrorMessage",
        .error_type = "ErrorType",
    };
};
