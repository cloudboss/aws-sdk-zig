/// Filters update actions from the service updates that are in available status
/// during
/// the time range.
pub const TimeRangeFilter = struct {
    /// The end time of the time range filter
    end_time: ?i64,

    /// The start time of the time range filter
    start_time: ?i64,
};
