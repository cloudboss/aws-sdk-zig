/// A validation error due to mismatch between the expected data type, length,
/// or pattern
/// of the parameter and the input.
pub const ValidationExceptionField = struct {
    /// A message about the validation error.
    message: []const u8,

    /// The name of the parameter field with the validation error.
    name: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .name = "name",
    };
};
