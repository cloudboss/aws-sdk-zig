pub const PolicyType = enum {
    rule_based,
    target_based,

    pub const json_field_names = .{
        .rule_based = "RuleBased",
        .target_based = "TargetBased",
    };
};
