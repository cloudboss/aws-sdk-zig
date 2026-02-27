/// Stores information about a field passed inside a request that resulted in an
/// exception.
pub const ValidationExceptionField = struct {
    /// A message with the reason for the validation exception error.
    message: []const u8,

    /// The field name where the invalid entry was detected.
    name: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .name = "name",
    };
};
