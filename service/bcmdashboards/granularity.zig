pub const Granularity = enum {
    hourly,
    daily,
    monthly,

    pub const json_field_names = .{
        .hourly = "HOURLY",
        .daily = "DAILY",
        .monthly = "MONTHLY",
    };
};
