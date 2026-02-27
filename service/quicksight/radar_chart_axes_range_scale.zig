pub const RadarChartAxesRangeScale = enum {
    auto,
    independent,
    shared,

    pub const json_field_names = .{
        .auto = "AUTO",
        .independent = "INDEPENDENT",
        .shared = "SHARED",
    };
};
