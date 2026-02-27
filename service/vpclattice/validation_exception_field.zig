/// Describes a validation failure.
pub const ValidationExceptionField = struct {
    /// Additional information about why the validation failed.
    message: []const u8,

    /// The name of the validation exception.
    name: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .name = "name",
    };
};
