const WriteForwardingStatus = @import("write_forwarding_status.zig").WriteForwardingStatus;
const GlobalClusterMemberSynchronizationStatus = @import("global_cluster_member_synchronization_status.zig").GlobalClusterMemberSynchronizationStatus;

/// A data structure with information about any primary and secondary clusters
/// associated with a global cluster (Aurora global database).
pub const GlobalClusterMember = struct {
    /// The Amazon Resource Name (ARN) for each Aurora DB cluster in the global
    /// cluster.
    db_cluster_arn: ?[]const u8,

    /// The status of write forwarding for a secondary cluster in the global
    /// cluster.
    global_write_forwarding_status: ?WriteForwardingStatus,

    /// Indicates whether the Aurora DB cluster is the primary cluster (that is, has
    /// read-write capability) for the global cluster with which it is associated.
    is_writer: ?bool,

    /// The Amazon Resource Name (ARN) for each read-only secondary cluster
    /// associated with the global cluster.
    readers: ?[]const []const u8,

    /// The status of synchronization of each Aurora DB cluster in the global
    /// cluster.
    synchronization_status: ?GlobalClusterMemberSynchronizationStatus,
};
