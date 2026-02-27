/// The field associated with the validation exception.
pub const ValidationExceptionField = struct {
    /// The message associated with the validation exception with information to
    /// help
    /// determine its cause.
    message: []const u8,

    /// The name of the field.
    name: []const u8,

    pub const json_field_names = .{
        .message = "Message",
        .name = "Name",
    };
};
