const ClusterSlurmNodeType = @import("cluster_slurm_node_type.zig").ClusterSlurmNodeType;

/// The Slurm configuration for an instance group in a SageMaker HyperPod
/// cluster.
pub const ClusterSlurmConfig = struct {
    /// The type of Slurm node for the instance group. Valid values are
    /// `Controller`, `Worker`, and `Login`.
    node_type: ClusterSlurmNodeType,

    /// The list of Slurm partition names that the instance group belongs to.
    partition_names: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .node_type = "NodeType",
        .partition_names = "PartitionNames",
    };
};
