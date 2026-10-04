const ResourceErrorCode = @import("resource_error_code.zig").ResourceErrorCode;

/// Contains the details of a resource error.
pub const ResourceError = struct {
    /// The error code.
    code: ?ResourceErrorCode = null,

    /// The error message.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};
