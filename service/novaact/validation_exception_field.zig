/// Information about a field that failed validation.
pub const ValidationExceptionField = struct {
    /// A description of the validation error for this field.
    message: []const u8,

    /// The name of the field that failed validation.
    name: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .name = "name",
    };
};
