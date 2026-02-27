const FieldValidationCode = @import("field_validation_code.zig").FieldValidationCode;

/// Contains information about a field-level validation error that occurred
/// during an operation.
pub const FieldValidationError = struct {
    /// A code identifying the specific field validation error.
    code: FieldValidationCode,

    /// A description of the field validation error.
    message: []const u8,

    /// The name of the field that failed validation.
    name: []const u8,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
        .name = "Name",
    };
};
