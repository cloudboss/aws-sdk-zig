/// Contains information about a validation exception field.
pub const ValidationExceptionField = struct {
    /// The message of the exception field.
    message: []const u8,

    /// The name of the exception field.
    name: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .name = "name",
    };
};
