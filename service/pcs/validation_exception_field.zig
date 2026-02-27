/// Stores information about a field in a request that caused an exception.
pub const ValidationExceptionField = struct {
    /// The message body of the exception.
    message: []const u8,

    /// The name of the exception.
    name: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .name = "name",
    };
};
