const ReplicationTimeValue = @import("replication_time_value.zig").ReplicationTimeValue;
const MetricsStatus = @import("metrics_status.zig").MetricsStatus;

/// A container specifying replication metrics-related settings enabling
/// replication metrics and
/// events.
pub const Metrics = struct {
    /// A container specifying the time threshold for emitting the
    /// `s3:Replication:OperationMissedThreshold` event.
    event_threshold: ?ReplicationTimeValue,

    /// Specifies whether the replication metrics are enabled.
    status: MetricsStatus,
};
