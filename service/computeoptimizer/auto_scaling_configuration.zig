pub const AutoScalingConfiguration = enum {
    target_tracking_scaling_cpu,
    target_tracking_scaling_memory,

    pub const json_field_names = .{
        .target_tracking_scaling_cpu = "TARGET_TRACKING_SCALING_CPU",
        .target_tracking_scaling_memory = "TARGET_TRACKING_SCALING_MEMORY",
    };
};
