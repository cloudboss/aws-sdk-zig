const ErrorCode = @import("error_code.zig").ErrorCode;

/// Contains error information for a pentest job that encountered an error.
pub const ErrorInformation = struct {
    /// The error code. Valid values include CLIENT_ERROR, INTERNAL_ERROR, and
    /// STOPPED_BY_USER.
    code: ?ErrorCode = null,

    /// A message describing the error.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};
