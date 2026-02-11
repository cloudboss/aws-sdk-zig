/// Error response to `GetFunctionConfiguration`.
pub const ImageConfigError = struct {
    /// Error code.
    error_code: ?[]const u8,

    /// Error message.
    message: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .message = "Message",
    };
};
