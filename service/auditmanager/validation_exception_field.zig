/// Indicates that the request has invalid or missing parameters for the field.
pub const ValidationExceptionField = struct {
    /// The body of the error message.
    message: []const u8,

    /// The name of the validation error.
    name: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .name = "name",
    };
};
