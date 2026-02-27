/// The length of time covered by the report.
pub const TimeUnit = enum {
    hourly,
    daily,
    monthly,

    pub const json_field_names = .{
        .hourly = "HOURLY",
        .daily = "DAILY",
        .monthly = "MONTHLY",
    };
};
