/// Contains information about a validation exception.
pub const ValidationExceptionField = struct {
    /// A message about the validation exception.
    message: []const u8,

    /// A path about the validation exception.
    path: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .path = "path",
    };
};
