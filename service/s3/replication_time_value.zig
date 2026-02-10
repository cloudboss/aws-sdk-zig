/// A container specifying the time value for S3 Replication Time Control (S3
/// RTC) and replication metrics
/// `EventThreshold`.
pub const ReplicationTimeValue = struct {
    /// Contains an integer specifying time in minutes.
    ///
    /// Valid value: 15
    minutes: ?i32,
};
