pub const ECSServiceRecommendationFindingReasonCode = enum {
    memory_over_provisioned,
    memory_under_provisioned,
    cpu_over_provisioned,
    cpu_under_provisioned,

    pub const json_field_names = .{
        .memory_over_provisioned = "MEMORY_OVER_PROVISIONED",
        .memory_under_provisioned = "MEMORY_UNDER_PROVISIONED",
        .cpu_over_provisioned = "CPU_OVER_PROVISIONED",
        .cpu_under_provisioned = "CPU_UNDER_PROVISIONED",
    };
};
