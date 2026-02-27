pub const ComparisonMethod = enum {
    difference,
    percent_difference,
    percent,

    pub const json_field_names = .{
        .difference = "DIFFERENCE",
        .percent_difference = "PERCENT_DIFFERENCE",
        .percent = "PERCENT",
    };
};
