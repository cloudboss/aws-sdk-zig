pub const EcsCapacityMonitoringApproach = enum {
    sampled_max_in_last_24_hours,
    container_insights_max_in_last_24_hours,

    pub const json_field_names = .{
        .sampled_max_in_last_24_hours = "SAMPLED_MAX_IN_LAST_24_HOURS",
        .container_insights_max_in_last_24_hours = "CONTAINER_INSIGHTS_MAX_IN_LAST_24_HOURS",
    };
};
