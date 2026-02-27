/// A container that specifies the time value for S3 Replication Time Control
/// (S3 RTC). This value is also used for
/// the replication metrics `EventThreshold` element.
///
/// This is not supported by Amazon S3 on Outposts buckets.
pub const ReplicationTimeValue = struct {
    /// Contains an integer that specifies the time period in minutes.
    ///
    /// Valid value: 15
    minutes: ?i32,
};
