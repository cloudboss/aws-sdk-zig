/// Validate exception field.
pub const ValidationExceptionField = struct {
    /// Validate exception field message.
    message: ?[]const u8,

    /// Validate exception field name.
    name: ?[]const u8,

    pub const json_field_names = .{
        .message = "message",
        .name = "name",
    };
};
