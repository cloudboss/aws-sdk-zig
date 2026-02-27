const ErrorCode = @import("error_code.zig").ErrorCode;

/// The error details.
pub const ErrorDetails = struct {
    /// The error code.
    code: ?ErrorCode,

    /// The error message.
    message: ?[]const u8,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};
