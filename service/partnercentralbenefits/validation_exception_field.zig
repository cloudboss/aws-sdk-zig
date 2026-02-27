const ValidationExceptionErrorCode = @import("validation_exception_error_code.zig").ValidationExceptionErrorCode;

/// Represents a field-specific validation error with detailed information.
pub const ValidationExceptionField = struct {
    /// An error code explaining why the field validation failed.
    code: ?ValidationExceptionErrorCode,

    /// A detailed message explaining why the field validation failed.
    message: []const u8,

    /// The name of the field that failed validation.
    name: []const u8,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
        .name = "Name",
    };
};
