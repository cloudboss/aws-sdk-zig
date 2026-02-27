const StackErrorCode = @import("stack_error_code.zig").StackErrorCode;

/// Describes a stack error.
pub const StackError = struct {
    /// The error code.
    error_code: ?StackErrorCode,

    /// The error message.
    error_message: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
    };
};
