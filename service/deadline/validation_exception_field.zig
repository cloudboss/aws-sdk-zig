/// The details of a validation exception.
pub const ValidationExceptionField = struct {
    /// The error message for the validation exception.
    message: []const u8,

    /// The name of the validation exception.
    name: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .name = "name",
    };
};
