const SharedResourceErrorCode = @import("shared_resource_error_code.zig").SharedResourceErrorCode;

/// Information on the error encountered by the resource.
pub const SharedResourceError = struct {
    /// The error code associated with the error.
    code: SharedResourceErrorCode,

    /// The error message.
    message: []const u8,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};
