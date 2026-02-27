pub const CustomizableMetricHeadroom = enum {
    percent_30,
    percent_20,
    percent_10,
    percent_0,

    pub const json_field_names = .{
        .percent_30 = "PERCENT_30",
        .percent_20 = "PERCENT_20",
        .percent_10 = "PERCENT_10",
        .percent_0 = "PERCENT_0",
    };
};
