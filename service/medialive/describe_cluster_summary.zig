const ClusterType = @import("cluster_type.zig").ClusterType;
const ClusterNetworkSettings = @import("cluster_network_settings.zig").ClusterNetworkSettings;
const ClusterState = @import("cluster_state.zig").ClusterState;

/// Used in ListClustersResult.
pub const DescribeClusterSummary = struct {
    /// The ARN of this Cluster. It is automatically assigned when the Cluster is
    /// created.
    arn: ?[]const u8,

    /// An array of the IDs of the Channels that are associated with this Cluster.
    /// One Channel is associated with the Cluster as follows: A Channel belongs to
    /// a ChannelPlacementGroup. A ChannelPlacementGroup is attached to a Node. A
    /// Node belongs to a Cluster.
    channel_ids: ?[]const []const u8,

    /// The hardware type for the Cluster.
    cluster_type: ?ClusterType,

    /// The ID of the Cluster. Unique in the AWS account. The ID is the resource-id
    /// portion of the ARN.
    id: ?[]const u8,

    /// The ARN of the IAM role for the Node in this Cluster. Any Nodes that are
    /// associated with this Cluster assume this role. The role gives permissions to
    /// the operations that you expect these Node to perform.
    instance_role_arn: ?[]const u8,

    /// The name that you specified for the Cluster.
    name: ?[]const u8,

    /// Network settings that connect the Nodes in the Cluster to one or more of the
    /// Networks that the Cluster is associated with.
    network_settings: ?ClusterNetworkSettings,

    /// The current state of the Cluster.
    state: ?ClusterState,

    pub const json_field_names = .{
        .arn = "Arn",
        .channel_ids = "ChannelIds",
        .cluster_type = "ClusterType",
        .id = "Id",
        .instance_role_arn = "InstanceRoleArn",
        .name = "Name",
        .network_settings = "NetworkSettings",
        .state = "State",
    };
};
