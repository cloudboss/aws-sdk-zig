pub const Objective = enum {
    auto,
    balanced,
    basic,
    high_throughput,
    low_latency,

    pub const json_field_names = .{
        .auto = "AUTO",
        .balanced = "BALANCED",
        .basic = "BASIC",
        .high_throughput = "HIGH_THROUGHPUT",
        .low_latency = "LOW_LATENCY",
    };
};
