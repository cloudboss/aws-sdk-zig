/// Error messages for environment variables that couldn't be applied.
pub const EnvironmentError = struct {
    /// The error code.
    error_code: ?[]const u8,

    /// The error message.
    message: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .message = "Message",
    };
};
