/// Information about a field that failed validation.
pub const ValidationExceptionField = struct {
    /// The validation error message for the field.
    message: []const u8,

    /// The name of the field that failed validation.
    name: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .name = "name",
    };
};
