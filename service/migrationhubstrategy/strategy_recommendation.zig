pub const StrategyRecommendation = enum {
    recommended,
    viable_option,
    not_recommended,
    potential,

    pub const json_field_names = .{
        .recommended = "RECOMMENDED",
        .viable_option = "VIABLE_OPTION",
        .not_recommended = "NOT_RECOMMENDED",
        .potential = "POTENTIAL",
    };
};
