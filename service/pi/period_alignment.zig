pub const PeriodAlignment = enum {
    end_time,
    start_time,

    pub const json_field_names = .{
        .end_time = "END_TIME",
        .start_time = "START_TIME",
    };
};
