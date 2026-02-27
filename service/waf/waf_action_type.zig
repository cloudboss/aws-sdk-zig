pub const WafActionType = enum {
    block,
    allow,
    count,

    pub const json_field_names = .{
        .block = "BLOCK",
        .allow = "ALLOW",
        .count = "COUNT",
    };
};
