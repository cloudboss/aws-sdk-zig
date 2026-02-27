/// An error describing why a schema could not be fetched.
pub const BatchGetSchemaError = struct {
    /// An error code for the error.
    code: []const u8,

    /// An error message for the error.
    message: []const u8,

    /// An error name for the error.
    name: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
        .name = "name",
    };
};
