const ReplicationTimeValue = @import("replication_time_value.zig").ReplicationTimeValue;
const MetricsStatus = @import("metrics_status.zig").MetricsStatus;

/// A container that specifies replication metrics-related settings.
pub const Metrics = struct {
    /// A container that specifies the time threshold for emitting the
    /// `s3:Replication:OperationMissedThreshold` event.
    ///
    /// This is not supported by Amazon S3 on Outposts buckets.
    event_threshold: ?ReplicationTimeValue = null,

    /// Specifies whether replication metrics are enabled.
    status: MetricsStatus,
};
