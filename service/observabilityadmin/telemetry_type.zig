pub const TelemetryType = enum {
    logs,
    metrics,
    traces,

    pub const json_field_names = .{
        .logs = "LOGS",
        .metrics = "METRICS",
        .traces = "TRACES",
    };
};
