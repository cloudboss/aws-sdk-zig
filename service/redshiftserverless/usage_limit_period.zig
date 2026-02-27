pub const UsageLimitPeriod = enum {
    daily,
    weekly,
    monthly,

    pub const json_field_names = .{
        .daily = "DAILY",
        .weekly = "WEEKLY",
        .monthly = "MONTHLY",
    };
};
