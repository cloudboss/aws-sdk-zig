/// Stores information about a field passed inside a request that resulted in an
/// exception.
pub const ValidationExceptionField = struct {
    /// A message describing why the field failed validation.
    message: []const u8,

    /// The field name.
    name: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .name = "name",
    };
};
