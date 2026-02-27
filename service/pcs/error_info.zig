/// An error that occurred during resource creation.
pub const ErrorInfo = struct {
    /// The short-form error code.
    code: ?[]const u8,

    /// The detailed error information.
    message: ?[]const u8,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};
