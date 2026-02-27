pub const AutoMLOverrideStrategy = enum {
    latency_optimized,
    accuracy_optimized,

    pub const json_field_names = .{
        .latency_optimized = "LatencyOptimized",
        .accuracy_optimized = "AccuracyOptimized",
    };
};
