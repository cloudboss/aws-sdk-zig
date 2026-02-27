pub const CustomizableMetricName = enum {
    cpu_utilization,
    memory_utilization,

    pub const json_field_names = .{
        .cpu_utilization = "CPU_UTILIZATION",
        .memory_utilization = "MEMORY_UTILIZATION",
    };
};
