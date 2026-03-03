const FlowConnection = @import("flow_connection.zig").FlowConnection;
const FlowNode = @import("flow_node.zig").FlowNode;

/// The definition of the nodes and connections between nodes in the flow.
pub const FlowDefinition = struct {
    /// An array of connection definitions in the flow.
    connections: ?[]const FlowConnection = null,

    /// An array of node definitions in the flow.
    nodes: ?[]const FlowNode = null,

    pub const json_field_names = .{
        .connections = "connections",
        .nodes = "nodes",
    };
};
