pub const ServiceLevelObjectiveBudgetStatus = enum {
    ok,
    warning,
    breached,
    insufficient_data,

    pub const json_field_names = .{
        .ok = "OK",
        .warning = "WARNING",
        .breached = "BREACHED",
        .insufficient_data = "INSUFFICIENT_DATA",
    };
};
