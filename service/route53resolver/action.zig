pub const Action = enum {
    allow,
    block,
    alert,

    pub const json_field_names = .{
        .allow = "ALLOW",
        .block = "BLOCK",
        .alert = "ALERT",
    };
};
