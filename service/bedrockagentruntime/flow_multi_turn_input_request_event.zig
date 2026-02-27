const FlowMultiTurnInputContent = @import("flow_multi_turn_input_content.zig").FlowMultiTurnInputContent;
const NodeType = @import("node_type.zig").NodeType;

/// Response object from the flow multi-turn node requesting additional
/// information.
pub const FlowMultiTurnInputRequestEvent = struct {
    /// The content payload containing the input request details for the multi-turn
    /// interaction.
    content: FlowMultiTurnInputContent,

    /// The name of the node in the flow that is requesting the input.
    node_name: []const u8,

    /// The type of the node in the flow that is requesting the input.
    node_type: NodeType,

    pub const json_field_names = .{
        .content = "content",
        .node_name = "nodeName",
        .node_type = "nodeType",
    };
};
