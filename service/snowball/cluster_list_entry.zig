const ClusterState = @import("cluster_state.zig").ClusterState;

/// Contains a cluster's state, a cluster's ID, and other important information.
pub const ClusterListEntry = struct {
    /// The 39-character ID for the cluster that you want to list, for example
    /// `CID123e4567-e89b-12d3-a456-426655440000`.
    cluster_id: ?[]const u8,

    /// The current state of this cluster. For information about the state of a
    /// specific node,
    /// see JobListEntry$JobState.
    cluster_state: ?ClusterState,

    /// The creation date for this cluster.
    creation_date: ?i64,

    /// Defines an optional description of the cluster, for example `Environmental
    /// Data
    /// Cluster-01`.
    description: ?[]const u8,

    pub const json_field_names = .{
        .cluster_id = "ClusterId",
        .cluster_state = "ClusterState",
        .creation_date = "CreationDate",
        .description = "Description",
    };
};
