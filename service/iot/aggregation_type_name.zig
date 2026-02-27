pub const AggregationTypeName = enum {
    statistics,
    percentiles,
    cardinality,

    pub const json_field_names = .{
        .statistics = "STATISTICS",
        .percentiles = "PERCENTILES",
        .cardinality = "CARDINALITY",
    };
};
