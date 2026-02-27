const DetailedErrorCode = @import("detailed_error_code.zig").DetailedErrorCode;

/// Contains detailed error information.
pub const DetailedError = struct {
    /// The error code.
    code: DetailedErrorCode,

    /// The error message.
    message: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};
