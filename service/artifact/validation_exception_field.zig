/// Validation exception message and name.
pub const ValidationExceptionField = struct {
    /// Message describing why the field failed validation.
    message: []const u8,

    /// Name of validation exception.
    name: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .name = "name",
    };
};
