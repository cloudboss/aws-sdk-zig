/// Earliest and latest time an instance can be restored to:
pub const RestoreWindow = struct {
    /// The earliest time you can restore an instance to.
    earliest_time: ?i64,

    /// The latest time you can restore an instance to.
    latest_time: ?i64,
};
