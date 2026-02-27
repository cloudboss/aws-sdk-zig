pub const StateInfo = struct {
    code: ?[]const u8,

    message: ?[]const u8,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};
