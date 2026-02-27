/// The output structure of the time range filter.
pub const TimeRangeFilterOutput = struct {
    /// The ending time for the time range filter.
    end_time: i64,

    /// The starting time for the time range filter.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .start_time = "StartTime",
    };
};
