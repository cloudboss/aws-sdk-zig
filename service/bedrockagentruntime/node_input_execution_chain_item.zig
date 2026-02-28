const FlowControlNodeType = @import("flow_control_node_type.zig").FlowControlNodeType;

/// Represents an item in the execution chain for node input tracking.
pub const NodeInputExecutionChainItem = struct {
    /// The index position of this item in the execution chain.
    index: ?i32,

    /// The name of the node in the execution chain.
    node_name: []const u8,

    /// The type of execution chain item. Supported values are Iterator and Loop.
    @"type": FlowControlNodeType,

    pub const json_field_names = .{
        .index = "index",
        .node_name = "nodeName",
        .@"type" = "type",
    };
};
