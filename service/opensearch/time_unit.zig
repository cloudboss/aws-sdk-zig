/// The unit of a maintenance schedule duration. Valid value is `HOUR`.
pub const TimeUnit = enum {
    hours,

    pub const json_field_names = .{
        .hours = "HOURS",
    };
};
