/// Describes a validation exception for a field.
pub const ValidationExceptionField = struct {
    /// The message for the field.
    message: []const u8,

    /// The name of the field.
    name: []const u8,

    pub const json_field_names = .{
        .message = "Message",
        .name = "Name",
    };
};
