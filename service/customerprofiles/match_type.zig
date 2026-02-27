pub const MatchType = enum {
    rule_based_matching,
    ml_based_matching,

    pub const json_field_names = .{
        .rule_based_matching = "RULE_BASED_MATCHING",
        .ml_based_matching = "ML_BASED_MATCHING",
    };
};
