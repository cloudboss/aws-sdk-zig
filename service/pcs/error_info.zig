/// An error that occurred during resource creation.
pub const ErrorInfo = struct {
    /// The short-form error code.
    code: ?[]const u8 = null,

    /// The detailed error information.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};
