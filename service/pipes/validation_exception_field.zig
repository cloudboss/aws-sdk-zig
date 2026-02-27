/// Indicates that an error has occurred while performing a validate operation.
pub const ValidationExceptionField = struct {
    /// The message of the exception.
    message: []const u8,

    /// The name of the exception.
    name: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .name = "name",
    };
};
