pub const EpochTimeUnit = enum {
    milliseconds,
    seconds,
    microseconds,
    nanoseconds,

    pub const json_field_names = .{
        .milliseconds = "MILLISECONDS",
        .seconds = "SECONDS",
        .microseconds = "MICROSECONDS",
        .nanoseconds = "NANOSECONDS",
    };
};
