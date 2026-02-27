pub const Granularity = enum {
    daily,
    monthly,
    hourly,

    pub const json_field_names = .{
        .daily = "DAILY",
        .monthly = "MONTHLY",
        .hourly = "HOURLY",
    };
};
