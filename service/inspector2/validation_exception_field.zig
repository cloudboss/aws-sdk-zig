/// An object that describes a validation exception.
pub const ValidationExceptionField = struct {
    /// The validation exception message.
    message: []const u8,

    /// The name of the validation exception.
    name: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .name = "name",
    };
};
