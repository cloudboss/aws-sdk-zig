pub const LicenseFinding = enum {
    insufficient_metrics,
    optimized,
    not_optimized,

    pub const json_field_names = .{
        .insufficient_metrics = "INSUFFICIENT_METRICS",
        .optimized = "OPTIMIZED",
        .not_optimized = "NOT_OPTIMIZED",
    };
};
