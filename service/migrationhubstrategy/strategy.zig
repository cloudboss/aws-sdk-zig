pub const Strategy = enum {
    rehost,
    retirement,
    refactor,
    replatform,
    retain,
    relocate,
    repurchase,

    pub const json_field_names = .{
        .rehost = "REHOST",
        .retirement = "RETIREMENT",
        .refactor = "REFACTOR",
        .replatform = "REPLATFORM",
        .retain = "RETAIN",
        .relocate = "RELOCATE",
        .repurchase = "REPURCHASE",
    };
};
