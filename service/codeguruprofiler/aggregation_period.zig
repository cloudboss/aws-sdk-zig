pub const AggregationPeriod = enum {
    /// Period of five minutes.
    pt5_m,
    /// Period of one hour.
    pt1_h,
    /// Period of one day.
    p1_d,

    pub const json_field_names = .{
        .pt5_m = "PT5M",
        .pt1_h = "PT1H",
        .p1_d = "P1D",
    };
};
