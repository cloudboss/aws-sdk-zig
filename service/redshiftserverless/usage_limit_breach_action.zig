pub const UsageLimitBreachAction = enum {
    log,
    emit_metric,
    deactivate,

    pub const json_field_names = .{
        .log = "LOG",
        .emit_metric = "EMIT_METRIC",
        .deactivate = "DEACTIVATE",
    };
};
