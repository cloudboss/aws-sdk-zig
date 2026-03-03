/// Error information.
pub const ErrorInfo = struct {
    /// The error code.
    code: ?[]const u8 = null,

    /// The error message.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};
