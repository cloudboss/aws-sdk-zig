pub const ECSServiceMetricName = enum {
    cpu,
    memory,

    pub const json_field_names = .{
        .cpu = "CPU",
        .memory = "MEMORY",
    };
};
