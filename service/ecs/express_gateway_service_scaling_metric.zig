pub const ExpressGatewayServiceScalingMetric = enum {
    average_cpu_utilization,
    average_memory_utilization,
    request_count_per_target,

    pub const json_field_names = .{
        .average_cpu_utilization = "AverageCPUUtilization",
        .average_memory_utilization = "AverageMemoryUtilization",
        .request_count_per_target = "RequestCountPerTarget",
    };
};
