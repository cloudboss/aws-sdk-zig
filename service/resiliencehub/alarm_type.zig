pub const AlarmType = enum {
    metric,
    composite,
    canary,
    logs,
    event,

    pub const json_field_names = .{
        .metric = "METRIC",
        .composite = "COMPOSITE",
        .canary = "CANARY",
        .logs = "LOGS",
        .event = "EVENT",
    };
};
