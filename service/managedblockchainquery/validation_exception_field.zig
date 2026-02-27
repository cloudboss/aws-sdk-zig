/// The resource passed is invalid.
pub const ValidationExceptionField = struct {
    /// The `ValidationException` message.
    message: []const u8,

    /// The name of the field that triggered the `ValidationException`.
    name: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .name = "name",
    };
};
