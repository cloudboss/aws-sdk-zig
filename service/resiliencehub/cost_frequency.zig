pub const CostFrequency = enum {
    hourly,
    daily,
    monthly,
    yearly,

    pub const json_field_names = .{
        .hourly = "HOURLY",
        .daily = "DAILY",
        .monthly = "MONTHLY",
        .yearly = "YEARLY",
    };
};
