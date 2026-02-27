const ClusterStatus = @import("cluster_status.zig").ClusterStatus;
const OperationMode = @import("operation_mode.zig").OperationMode;
const ReplicationMode = @import("replication_mode.zig").ReplicationMode;

/// Details of the SAP HANA system replication for the instance.
pub const Resilience = struct {
    /// The cluster status of the component.
    cluster_status: ?ClusterStatus,

    /// Indicates if or not enqueue replication is enabled for the ASCS component.
    enqueue_replication: ?bool,

    /// The operation mode of the component.
    hsr_operation_mode: ?OperationMode,

    /// The replication mode of the component.
    hsr_replication_mode: ?ReplicationMode,

    /// The tier of the component.
    hsr_tier: ?[]const u8,

    pub const json_field_names = .{
        .cluster_status = "ClusterStatus",
        .enqueue_replication = "EnqueueReplication",
        .hsr_operation_mode = "HsrOperationMode",
        .hsr_replication_mode = "HsrReplicationMode",
        .hsr_tier = "HsrTier",
    };
};
