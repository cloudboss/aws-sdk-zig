pub const StateInfo = struct {
    code: ?[]const u8 = null,

    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};
