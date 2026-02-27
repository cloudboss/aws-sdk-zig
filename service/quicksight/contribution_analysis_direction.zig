pub const ContributionAnalysisDirection = enum {
    increase,
    decrease,
    neutral,

    pub const json_field_names = .{
        .increase = "INCREASE",
        .decrease = "DECREASE",
        .neutral = "NEUTRAL",
    };
};
