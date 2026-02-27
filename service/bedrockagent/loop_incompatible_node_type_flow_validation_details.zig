const IncompatibleLoopNodeType = @import("incompatible_loop_node_type.zig").IncompatibleLoopNodeType;

/// Details about a flow that contains an incompatible node in a DoWhile loop.
pub const LoopIncompatibleNodeTypeFlowValidationDetails = struct {
    /// The node that's incompatible in the DoWhile loop.
    incompatible_node_name: []const u8,

    /// The node type of the incompatible node in the DoWhile loop. Some node types,
    /// like a condition node, aren't allowed in a DoWhile loop.
    incompatible_node_type: IncompatibleLoopNodeType,

    /// The `Loop` container node that contains an incompatible node.
    node: []const u8,

    pub const json_field_names = .{
        .incompatible_node_name = "incompatibleNodeName",
        .incompatible_node_type = "incompatibleNodeType",
        .node = "node",
    };
};
