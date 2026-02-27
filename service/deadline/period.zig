pub const Period = enum {
    hourly,
    daily,
    weekly,
    monthly,

    pub const json_field_names = .{
        .hourly = "HOURLY",
        .daily = "DAILY",
        .weekly = "WEEKLY",
        .monthly = "MONTHLY",
    };
};
