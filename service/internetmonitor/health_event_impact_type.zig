pub const HealthEventImpactType = enum {
    availability,
    performance,
    local_availability,
    local_performance,

    pub const json_field_names = .{
        .availability = "AVAILABILITY",
        .performance = "PERFORMANCE",
        .local_availability = "LOCAL_AVAILABILITY",
        .local_performance = "LOCAL_PERFORMANCE",
    };
};
