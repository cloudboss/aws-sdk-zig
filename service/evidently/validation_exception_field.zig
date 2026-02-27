/// A structure containing an error name and message.
pub const ValidationExceptionField = struct {
    /// The error message.
    message: []const u8,

    /// The error name.
    name: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .name = "name",
    };
};
