pub const DecisionTaskTimeoutType = enum {
    start_to_close,
    schedule_to_start,

    pub const json_field_names = .{
        .start_to_close = "START_TO_CLOSE",
        .schedule_to_start = "SCHEDULE_TO_START",
    };
};
