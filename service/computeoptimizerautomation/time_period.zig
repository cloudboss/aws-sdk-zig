/// Defines a time range with inclusive start time and exclusive end time for
/// filtering and analysis.
pub const TimePeriod = struct {
    /// The end time of the period, exclusive. Events before this time are included.
    end_time_exclusive: ?i64,

    /// The start time of the period, inclusive. Events at or after this time are
    /// included.
    start_time_inclusive: ?i64,

    pub const json_field_names = .{
        .end_time_exclusive = "endTimeExclusive",
        .start_time_inclusive = "startTimeInclusive",
    };
};
