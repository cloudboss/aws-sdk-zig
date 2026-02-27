pub const ScheduleAt = enum {
    now,
    timestamp,
    off_peak_window,

    pub const json_field_names = .{
        .now = "NOW",
        .timestamp = "TIMESTAMP",
        .off_peak_window = "OFF_PEAK_WINDOW",
    };
};
