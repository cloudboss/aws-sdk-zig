const ClusterNode = @import("cluster_node.zig").ClusterNode;

/// The AvailabilityZone and ClusterNodes information of the secondary compute
/// unit.
pub const SecondaryClusterInfo = struct {
    /// The name of the Availability Zone in which the secondary compute unit of the
    /// cluster is located.
    availability_zone: ?[]const u8 = null,

    /// The nodes in the secondary compute unit.
    cluster_nodes: ?[]const ClusterNode = null,
};
