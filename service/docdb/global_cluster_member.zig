const GlobalClusterMemberSynchronizationStatus = @import("global_cluster_member_synchronization_status.zig").GlobalClusterMemberSynchronizationStatus;

/// A data structure with information about any primary and secondary clusters
/// associated with an Amazon DocumentDB global clusters.
pub const GlobalClusterMember = struct {
    /// The Amazon Resource Name (ARN) for each Amazon DocumentDB cluster.
    db_cluster_arn: ?[]const u8,

    /// Specifies whether the Amazon DocumentDB cluster is the primary cluster (that
    /// is, has read-write capability) for the Amazon DocumentDB global cluster with
    /// which it is associated.
    is_writer: ?bool,

    /// The Amazon Resource Name (ARN) for each read-only secondary cluster
    /// associated with the Amazon DocumentDB global cluster.
    readers: ?[]const []const u8,

    /// The status of synchronization of each Amazon DocumentDB cluster in the
    /// global cluster.
    synchronization_status: ?GlobalClusterMemberSynchronizationStatus,
};
