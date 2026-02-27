/// The time unit of the budget, such as MONTHLY or QUARTERLY.
pub const TimeUnit = enum {
    daily,
    monthly,
    quarterly,
    annually,
    custom,

    pub const json_field_names = .{
        .daily = "DAILY",
        .monthly = "MONTHLY",
        .quarterly = "QUARTERLY",
        .annually = "ANNUALLY",
        .custom = "CUSTOM",
    };
};
