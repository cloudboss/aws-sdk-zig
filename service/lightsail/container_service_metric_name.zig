pub const ContainerServiceMetricName = enum {
    cpu_utilization,
    memory_utilization,

    pub const json_field_names = .{
        .cpu_utilization = "CPUUtilization",
        .memory_utilization = "MemoryUtilization",
    };
};
