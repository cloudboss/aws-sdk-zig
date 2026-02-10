const ReplicationTimeStatus = @import("replication_time_status.zig").ReplicationTimeStatus;
const ReplicationTimeValue = @import("replication_time_value.zig").ReplicationTimeValue;

/// A container specifying S3 Replication Time Control (S3 RTC) related
/// information, including whether S3 RTC is enabled and
/// the time when all objects and operations on objects must be replicated. Must
/// be specified together with
/// a `Metrics` block.
pub const ReplicationTime = struct {
    /// Specifies whether the replication time is enabled.
    status: ReplicationTimeStatus,

    /// A container specifying the time by which replication should be complete for
    /// all objects and
    /// operations on objects.
    time: ReplicationTimeValue,
};
