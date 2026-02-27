pub const CustomizableMetricThreshold = enum {
    p90,
    p95,
    p99_5,

    pub const json_field_names = .{
        .p90 = "P90",
        .p95 = "P95",
        .p99_5 = "P99_5",
    };
};
