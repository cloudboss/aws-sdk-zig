/// Stores information about a field passed inside a request that resulted in an
/// exception.
pub const ValidationExceptionField = struct {
    /// A message describing why this field failed validation.
    message: []const u8,

    /// The name of the field.
    name: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .name = "name",
    };
};
