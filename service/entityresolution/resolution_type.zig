pub const ResolutionType = enum {
    rule_matching,
    ml_matching,
    provider,

    pub const json_field_names = .{
        .rule_matching = "RULE_MATCHING",
        .ml_matching = "ML_MATCHING",
        .provider = "PROVIDER",
    };
};
