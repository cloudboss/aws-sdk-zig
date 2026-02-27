pub const SuppressionUnit = enum {
    seconds,
    minutes,
    hours,

    pub const json_field_names = .{
        .seconds = "SECONDS",
        .minutes = "MINUTES",
        .hours = "HOURS",
    };
};
