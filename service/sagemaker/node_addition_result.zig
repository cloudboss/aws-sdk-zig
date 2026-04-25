const ClusterInstanceType = @import("cluster_instance_type.zig").ClusterInstanceType;
const ClusterInstanceStatus = @import("cluster_instance_status.zig").ClusterInstanceStatus;

/// Information about a node that was successfully added to the cluster.
pub const NodeAdditionResult = struct {
    /// The availability zones associated with the successfully added node.
    availability_zones: ?[]const []const u8 = null,

    /// The name of the instance group to which the node was added.
    instance_group_name: []const u8,

    /// The instance types associated with the successfully added node.
    instance_types: ?[]const ClusterInstanceType = null,

    /// A unique identifier assigned to the node that can be used to track its
    /// provisioning status through the `DescribeClusterNode` operation.
    node_logical_id: []const u8,

    /// The current status of the node. Possible values include `Pending`,
    /// `Running`, `Failed`, `ShuttingDown`, `SystemUpdating`,
    /// `DeepHealthCheckInProgress`, and `NotFound`.
    status: ClusterInstanceStatus,

    pub const json_field_names = .{
        .availability_zones = "AvailabilityZones",
        .instance_group_name = "InstanceGroupName",
        .instance_types = "InstanceTypes",
        .node_logical_id = "NodeLogicalId",
        .status = "Status",
    };
};
