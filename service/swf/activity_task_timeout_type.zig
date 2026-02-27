pub const ActivityTaskTimeoutType = enum {
    start_to_close,
    schedule_to_start,
    schedule_to_close,
    heartbeat,

    pub const json_field_names = .{
        .start_to_close = "START_TO_CLOSE",
        .schedule_to_start = "SCHEDULE_TO_START",
        .schedule_to_close = "SCHEDULE_TO_CLOSE",
        .heartbeat = "HEARTBEAT",
    };
};
