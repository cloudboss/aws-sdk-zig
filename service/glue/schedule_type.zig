pub const ScheduleType = enum {
    cron,
    auto,

    pub const json_field_names = .{
        .cron = "CRON",
        .auto = "AUTO",
    };
};
