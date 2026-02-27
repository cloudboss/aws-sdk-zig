pub const LambdaFunctionMetricName = enum {
    duration,
    memory,

    pub const json_field_names = .{
        .duration = "DURATION",
        .memory = "MEMORY",
    };
};
