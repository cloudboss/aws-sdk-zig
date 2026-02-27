pub const ScheduleFrequencyType = enum {
    byminute,
    hourly,
    daily,
    weekly,
    monthly,
    once,

    pub const json_field_names = .{
        .byminute = "BYMINUTE",
        .hourly = "HOURLY",
        .daily = "DAILY",
        .weekly = "WEEKLY",
        .monthly = "MONTHLY",
        .once = "ONCE",
    };
};
