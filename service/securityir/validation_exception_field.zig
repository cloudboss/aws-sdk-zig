pub const ValidationExceptionField = struct {
    message: []const u8,

    name: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .name = "name",
    };
};
