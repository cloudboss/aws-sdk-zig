const NodeConfig = @import("node_config.zig").NodeConfig;
const NodeOptionsNodeType = @import("node_options_node_type.zig").NodeOptionsNodeType;

/// Configuration settings for defining the node type within a cluster.
pub const NodeOption = struct {
    /// Configuration options for defining the setup of any node type.
    node_config: ?NodeConfig,

    /// Defines the type of node, such as coordinating nodes.
    node_type: ?NodeOptionsNodeType,

    pub const json_field_names = .{
        .node_config = "NodeConfig",
        .node_type = "NodeType",
    };
};
