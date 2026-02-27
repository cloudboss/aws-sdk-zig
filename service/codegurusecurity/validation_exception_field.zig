/// Information about a validation exception.
pub const ValidationExceptionField = struct {
    /// Describes the exception.
    message: []const u8,

    /// The name of the exception.
    name: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .name = "name",
    };
};
