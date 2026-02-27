/// Information about a field passed into a request that resulted in an
/// exception.
pub const ValidationExceptionField = struct {
    /// A message describing why the field caused an exception.
    message: []const u8,

    /// The name of the field that caused an exception.
    name: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .name = "name",
    };
};
