pub const SamplingStrategyName = enum {
    partial_scan,
    fixed_rate,

    pub const json_field_names = .{
        .partial_scan = "PartialScan",
        .fixed_rate = "FixedRate",
    };
};
