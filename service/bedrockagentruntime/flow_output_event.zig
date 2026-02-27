const FlowOutputContent = @import("flow_output_content.zig").FlowOutputContent;
const NodeType = @import("node_type.zig").NodeType;

/// Contains information about an output from prompt flow invoction.
pub const FlowOutputEvent = struct {
    /// The content in the output.
    content: FlowOutputContent,

    /// The name of the flow output node that the output is from.
    node_name: []const u8,

    /// The type of the node that the output is from.
    node_type: NodeType,

    pub const json_field_names = .{
        .content = "content",
        .node_name = "nodeName",
        .node_type = "nodeType",
    };
};
