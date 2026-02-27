const InstanceReplicationStatus = @import("instance_replication_status.zig").InstanceReplicationStatus;

/// Status information about the replication process, where you use the
/// [ReplicateInstance](https://docs.aws.amazon.com/connect/latest/APIReference/API_ReplicateInstance.html) API to create a replica of
/// your Amazon Connect instance in another Amazon Web Services Region. For more
/// information, see [Set up Amazon Connect
/// Global
/// Resiliency](https://docs.aws.amazon.com/connect/latest/adminguide/setup-connect-global-resiliency.html) in the *Amazon Connect Administrator Guide*.
pub const ReplicationStatusSummary = struct {
    /// The Amazon Web Services Region. This can be either the source or the replica
    /// Region, depending where it appears
    /// in the summary list.
    region: ?[]const u8,

    /// The state of the replication.
    replication_status: ?InstanceReplicationStatus,

    /// A description of the replication status. Use this information to resolve any
    /// issues that are preventing the
    /// successful replication of your Amazon Connect instance to another Region.
    replication_status_reason: ?[]const u8,

    pub const json_field_names = .{
        .region = "Region",
        .replication_status = "ReplicationStatus",
        .replication_status_reason = "ReplicationStatusReason",
    };
};
