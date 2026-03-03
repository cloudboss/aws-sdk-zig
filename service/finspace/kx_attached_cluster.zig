const KxClusterStatus = @import("kx_cluster_status.zig").KxClusterStatus;
const KxClusterType = @import("kx_cluster_type.zig").KxClusterType;

/// The structure containing the metadata of the attached clusters.
pub const KxAttachedCluster = struct {
    /// A unique name for the attached cluster.
    cluster_name: ?[]const u8 = null,

    /// The status of the attached cluster.
    ///
    /// * PENDING – The cluster is pending creation.
    ///
    /// * CREATING – The cluster creation process is in progress.
    ///
    /// * CREATE_FAILED – The cluster creation process has failed.
    ///
    /// * RUNNING – The cluster creation process is running.
    ///
    /// * UPDATING – The cluster is in the process of being updated.
    ///
    /// * DELETING – The cluster is in the process of being deleted.
    ///
    /// * DELETED – The cluster has been deleted.
    ///
    /// * DELETE_FAILED – The cluster failed to delete.
    cluster_status: ?KxClusterStatus = null,

    /// Specifies the type of cluster. The volume for TP and RDB cluster types will
    /// be used for TP logs.
    cluster_type: ?KxClusterType = null,

    pub const json_field_names = .{
        .cluster_name = "clusterName",
        .cluster_status = "clusterStatus",
        .cluster_type = "clusterType",
    };
};
