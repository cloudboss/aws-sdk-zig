/// The input for the time-range filter.
pub const TimeRangeFilterInput = struct {
    /// The end time for the time-range filter.
    end_time: i64,

    /// The start time for the time-range filter.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .start_time = "StartTime",
    };
};
