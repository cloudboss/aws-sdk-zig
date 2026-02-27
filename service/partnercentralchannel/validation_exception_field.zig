/// Information about a field that failed validation.
pub const ValidationExceptionField = struct {
    /// The validation error code for the field.
    code: []const u8,

    /// A descriptive message about the validation error.
    message: []const u8,

    /// The name of the field that failed validation.
    name: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
        .name = "name",
    };
};
