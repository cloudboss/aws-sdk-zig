const ReplicationTimeStatus = @import("replication_time_status.zig").ReplicationTimeStatus;
const ReplicationTimeValue = @import("replication_time_value.zig").ReplicationTimeValue;

/// A container that specifies S3 Replication Time Control (S3 RTC) related
/// information, including whether S3 RTC
/// is enabled and the time when all objects and operations on objects must be
/// replicated.
///
/// This is not supported by Amazon S3 on Outposts buckets.
pub const ReplicationTime = struct {
    /// Specifies whether S3 Replication Time Control (S3 RTC) is enabled.
    status: ReplicationTimeStatus,

    /// A container that specifies the time by which replication should be complete
    /// for all
    /// objects and operations on objects.
    time: ReplicationTimeValue,
};
