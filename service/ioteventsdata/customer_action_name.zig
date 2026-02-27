pub const CustomerActionName = enum {
    snooze,
    enable,
    disable,
    acknowledge,
    reset,

    pub const json_field_names = .{
        .snooze = "SNOOZE",
        .enable = "ENABLE",
        .disable = "DISABLE",
        .acknowledge = "ACKNOWLEDGE",
        .reset = "RESET",
    };
};
