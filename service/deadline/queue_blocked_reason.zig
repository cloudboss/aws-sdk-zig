pub const QueueBlockedReason = enum {
    no_budget_configured,
    budget_threshold_reached,

    pub const json_field_names = .{
        .no_budget_configured = "NO_BUDGET_CONFIGURED",
        .budget_threshold_reached = "BUDGET_THRESHOLD_REACHED",
    };
};
