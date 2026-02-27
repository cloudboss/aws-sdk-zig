/// A structure that contains information about a request parameter that caused
/// an
/// error.
pub const ValidationExceptionField = struct {
    /// A message describing why this field couldn't be validated.
    message: []const u8,

    /// The name of the field that caused the validation error.
    name: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .name = "name",
    };
};
