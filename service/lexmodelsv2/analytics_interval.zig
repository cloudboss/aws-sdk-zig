pub const AnalyticsInterval = enum {
    one_hour,
    one_day,

    pub const json_field_names = .{
        .one_hour = "OneHour",
        .one_day = "OneDay",
    };
};
