/// Provides a range of time.
pub const TimeRange = struct {
    /// The Unix timestamp for the end of the time range.
    end_time: ?i64 = null,

    /// The Unix timestamp for the beginning of the time range.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .start_time = "StartTime",
    };
};
