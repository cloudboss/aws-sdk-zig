pub const Frequency = enum {
    once,
    hourly,
    daily,
    weekly,
    monthly,
    event,
    in_app_event,

    pub const json_field_names = .{
        .once = "ONCE",
        .hourly = "HOURLY",
        .daily = "DAILY",
        .weekly = "WEEKLY",
        .monthly = "MONTHLY",
        .event = "EVENT",
        .in_app_event = "IN_APP_EVENT",
    };
};
