pub const AcceptRuleBehavior = enum {
    all,
    none,

    pub const json_field_names = .{
        .all = "ALL",
        .none = "NONE",
    };
};
