pub const RefreshScheduleFrequencyUnit = enum {
    hours,
    days,

    pub const json_field_names = .{
        .hours = "HOURS",
        .days = "DAYS",
    };
};
