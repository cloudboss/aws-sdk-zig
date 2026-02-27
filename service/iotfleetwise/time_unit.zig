pub const TimeUnit = enum {
    millisecond,
    second,
    minute,
    hour,

    pub const json_field_names = .{
        .millisecond = "MILLISECOND",
        .second = "SECOND",
        .minute = "MINUTE",
        .hour = "HOUR",
    };
};
