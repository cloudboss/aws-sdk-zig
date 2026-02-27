const ClusterInstanceStatus = @import("cluster_instance_status.zig").ClusterInstanceStatus;

/// Information about a node that was successfully added to the cluster.
pub const NodeAdditionResult = struct {
    /// The name of the instance group to which the node was added.
    instance_group_name: []const u8,

    /// A unique identifier assigned to the node that can be used to track its
    /// provisioning status through the `DescribeClusterNode` operation.
    node_logical_id: []const u8,

    /// The current status of the node. Possible values include `Pending`,
    /// `Running`, `Failed`, `ShuttingDown`, `SystemUpdating`,
    /// `DeepHealthCheckInProgress`, and `NotFound`.
    status: ClusterInstanceStatus,

    pub const json_field_names = .{
        .instance_group_name = "InstanceGroupName",
        .node_logical_id = "NodeLogicalId",
        .status = "Status",
    };
};
