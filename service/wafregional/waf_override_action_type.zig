pub const WafOverrideActionType = enum {
    none,
    count,

    pub const json_field_names = .{
        .none = "NONE",
        .count = "COUNT",
    };
};
