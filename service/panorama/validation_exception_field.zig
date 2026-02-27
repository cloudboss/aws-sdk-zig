/// A validation exception field.
pub const ValidationExceptionField = struct {
    /// The field's message.
    message: []const u8,

    /// The field's name.
    name: []const u8,

    pub const json_field_names = .{
        .message = "Message",
        .name = "Name",
    };
};
