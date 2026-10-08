/// Describes a validation exception for a specific field.
pub const ValidationExceptionField = struct {
    /// A message describing the validation exception.
    message: []const u8,

    /// The field name with the validation exception.
    path: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .path = "path",
    };
};
