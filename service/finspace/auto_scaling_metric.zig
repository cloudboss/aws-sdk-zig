pub const AutoScalingMetric = enum {
    cpu_utilization_percentage,

    pub const json_field_names = .{
        .cpu_utilization_percentage = "CPU_UTILIZATION_PERCENTAGE",
    };
};
