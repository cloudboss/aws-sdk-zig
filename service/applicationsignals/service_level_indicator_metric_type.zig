pub const ServiceLevelIndicatorMetricType = enum {
    latency,
    availability,

    pub const json_field_names = .{
        .latency = "LATENCY",
        .availability = "AVAILABILITY",
    };
};
