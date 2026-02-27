pub const LookbackWindowSizeUnit = enum {
    hour,
    day,
    week,

    pub const json_field_names = .{
        .hour = "HOUR",
        .day = "DAY",
        .week = "WEEK",
    };
};
