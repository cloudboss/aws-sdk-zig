pub const DurationUnit = enum {
    minute,
    hour,
    day,
    month,

    pub const json_field_names = .{
        .minute = "MINUTE",
        .hour = "HOUR",
        .day = "DAY",
        .month = "MONTH",
    };
};
