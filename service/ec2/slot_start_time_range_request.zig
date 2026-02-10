/// Describes the time period for a Scheduled Instance to start its first
/// schedule.
pub const SlotStartTimeRangeRequest = struct {
    /// The earliest date and time, in UTC, for the Scheduled Instance to start.
    earliest_time: ?i64,

    /// The latest date and time, in UTC, for the Scheduled Instance to start.
    latest_time: ?i64,
};
