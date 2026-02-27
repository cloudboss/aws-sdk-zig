/// This object is used in the ValidationException error.
pub const ValidationExceptionField = struct {
    /// Explanation of the reason for the validation error.
    message: []const u8,

    /// Name of the field which failed validation.
    name: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .name = "name",
    };
};
