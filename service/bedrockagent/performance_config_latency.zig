pub const PerformanceConfigLatency = enum {
    standard,
    optimized,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .optimized = "OPTIMIZED",
    };
};
