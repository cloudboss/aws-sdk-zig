pub const WafRuleType = enum {
    regular,
    rate_based,
    group,

    pub const json_field_names = .{
        .regular = "REGULAR",
        .rate_based = "RATE_BASED",
        .group = "GROUP",
    };
};
