/// Provides specific details about why a particular field failed validation.
pub const ValidationExceptionField = struct {
    /// Provides a message explaining why the field failed validation.
    message: []const u8,

    /// Provides the name of the field that failed validation.
    name: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .name = "name",
    };
};
