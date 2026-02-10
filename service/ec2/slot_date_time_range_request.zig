/// Describes the time period for a Scheduled Instance to start its first
/// schedule. The time period must span less than one day.
pub const SlotDateTimeRangeRequest = struct {
    /// The earliest date and time, in UTC, for the Scheduled Instance to start.
    earliest_time: i64,

    /// The latest date and time, in UTC, for the Scheduled Instance to start. This
    /// value must be later than or equal to the earliest date and at most three
    /// months in the future.
    latest_time: i64,
};
