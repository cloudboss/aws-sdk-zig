const BrokerNodeInfo = @import("broker_node_info.zig").BrokerNodeInfo;
const ControllerNodeInfo = @import("controller_node_info.zig").ControllerNodeInfo;
const NodeType = @import("node_type.zig").NodeType;
const ZookeeperNodeInfo = @import("zookeeper_node_info.zig").ZookeeperNodeInfo;

/// The node information object.
pub const NodeInfo = struct {
    /// The start time.
    added_to_cluster_time: ?[]const u8 = null,

    /// The broker node info.
    broker_node_info: ?BrokerNodeInfo = null,

    /// The ControllerNodeInfo.
    controller_node_info: ?ControllerNodeInfo = null,

    /// The instance type.
    instance_type: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the node.
    node_arn: ?[]const u8 = null,

    /// The node type.
    node_type: ?NodeType = null,

    /// The ZookeeperNodeInfo.
    zookeeper_node_info: ?ZookeeperNodeInfo = null,

    pub const json_field_names = .{
        .added_to_cluster_time = "AddedToClusterTime",
        .broker_node_info = "BrokerNodeInfo",
        .controller_node_info = "ControllerNodeInfo",
        .instance_type = "InstanceType",
        .node_arn = "NodeARN",
        .node_type = "NodeType",
        .zookeeper_node_info = "ZookeeperNodeInfo",
    };
};
