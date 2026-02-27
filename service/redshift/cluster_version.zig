/// Describes a cluster version, including the parameter group family and
/// description
/// of the version.
pub const ClusterVersion = struct {
    /// The name of the cluster parameter group family for the cluster.
    cluster_parameter_group_family: ?[]const u8,

    /// The version number used by the cluster.
    cluster_version: ?[]const u8,

    /// The description of the cluster version.
    description: ?[]const u8,
};
