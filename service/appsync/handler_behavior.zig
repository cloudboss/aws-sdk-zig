pub const HandlerBehavior = enum {
    code,
    direct,

    pub const json_field_names = .{
        .code = "CODE",
        .direct = "DIRECT",
    };
};
