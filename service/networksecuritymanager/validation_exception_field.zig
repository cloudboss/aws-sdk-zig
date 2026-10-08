/// Describes a single request field that failed validation.
pub const ValidationExceptionField = struct {
    /// A message describing the validation error for the field.
    message: []const u8,

    /// The name of the field that failed validation.
    name: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .name = "name",
    };
};
