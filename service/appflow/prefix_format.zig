pub const PrefixFormat = enum {
    year,
    month,
    day,
    hour,
    minute,

    pub const json_field_names = .{
        .year = "YEAR",
        .month = "MONTH",
        .day = "DAY",
        .hour = "HOUR",
        .minute = "MINUTE",
    };
};
