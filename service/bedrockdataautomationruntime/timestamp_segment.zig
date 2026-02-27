/// Timestamp segment
pub const TimestampSegment = struct {
    /// End timestamp in milliseconds
    end_time_millis: i64,

    /// Start timestamp in milliseconds
    start_time_millis: i64,

    pub const json_field_names = .{
        .end_time_millis = "endTimeMillis",
        .start_time_millis = "startTimeMillis",
    };
};
