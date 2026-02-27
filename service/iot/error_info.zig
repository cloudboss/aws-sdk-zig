/// Error information.
pub const ErrorInfo = struct {
    /// The error code.
    code: ?[]const u8,

    /// The error message.
    message: ?[]const u8,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};
