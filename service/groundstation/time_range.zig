/// A time range with a start and end time.
pub const TimeRange = struct {
    /// Unix epoch timestamp in UTC at which the time range ends.
    end_time: i64,

    /// Unix epoch timestamp in UTC at which the time range starts.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "endTime",
        .start_time = "startTime",
    };
};
