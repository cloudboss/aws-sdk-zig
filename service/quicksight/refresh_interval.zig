pub const RefreshInterval = enum {
    minute15,
    minute30,
    hourly,
    daily,
    weekly,
    monthly,

    pub const json_field_names = .{
        .minute15 = "MINUTE15",
        .minute30 = "MINUTE30",
        .hourly = "HOURLY",
        .daily = "DAILY",
        .weekly = "WEEKLY",
        .monthly = "MONTHLY",
    };
};
