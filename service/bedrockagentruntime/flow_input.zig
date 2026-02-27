const FlowInputContent = @import("flow_input_content.zig").FlowInputContent;

/// Contains information about an input into the prompt flow and where to send
/// it.
pub const FlowInput = struct {
    /// Contains information about an input into the prompt flow.
    content: FlowInputContent,

    /// The name of the input from the flow input node.
    node_input_name: ?[]const u8,

    /// The name of the flow input node that begins the prompt flow.
    node_name: []const u8,

    /// The name of the output from the flow input node that begins the prompt flow.
    node_output_name: ?[]const u8,

    pub const json_field_names = .{
        .content = "content",
        .node_input_name = "nodeInputName",
        .node_name = "nodeName",
        .node_output_name = "nodeOutputName",
    };
};
