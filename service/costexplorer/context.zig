pub const Context = enum {
    cost_and_usage,
    reservations,
    savings_plans,

    pub const json_field_names = .{
        .cost_and_usage = "COST_AND_USAGE",
        .reservations = "RESERVATIONS",
        .savings_plans = "SAVINGS_PLANS",
    };
};
