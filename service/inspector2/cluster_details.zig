const ClusterMetadata = @import("cluster_metadata.zig").ClusterMetadata;

/// Details about the task or pod in the cluster.
pub const ClusterDetails = struct {
    cluster_metadata: ClusterMetadata,

    /// The last timestamp when Amazon Inspector recorded the image in use in the
    /// task or pod
    /// in the cluster.
    last_in_use: i64,

    /// The number of tasks or pods where an image was running on the cluster.
    running_unit_count: ?i64,

    /// The number of tasks or pods where an image was stopped on the cluster in the
    /// last 24
    /// hours.
    stopped_unit_count: ?i64,

    pub const json_field_names = .{
        .cluster_metadata = "clusterMetadata",
        .last_in_use = "lastInUse",
        .running_unit_count = "runningUnitCount",
        .stopped_unit_count = "stoppedUnitCount",
    };
};
