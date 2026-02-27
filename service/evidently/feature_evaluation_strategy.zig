pub const FeatureEvaluationStrategy = enum {
    all_rules,
    default_variation,

    pub const json_field_names = .{
        .all_rules = "ALL_RULES",
        .default_variation = "DEFAULT_VARIATION",
    };
};
