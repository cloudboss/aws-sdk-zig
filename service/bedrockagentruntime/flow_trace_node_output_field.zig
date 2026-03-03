const FlowTraceNodeOutputContent = @import("flow_trace_node_output_content.zig").FlowTraceNodeOutputContent;
const FlowTraceNodeOutputNext = @import("flow_trace_node_output_next.zig").FlowTraceNodeOutputNext;
const FlowNodeIODataType = @import("flow_node_io_data_type.zig").FlowNodeIODataType;

/// Contains information about a field in the output from a node. For more
/// information, see [Track each step in your prompt flow by viewing its trace
/// in Amazon
/// Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/flows-trace.html).
pub const FlowTraceNodeOutputField = struct {
    /// The content of the node output.
    content: FlowTraceNodeOutputContent,

    /// The next node that receives output data from this field.
    next: ?[]const FlowTraceNodeOutputNext = null,

    /// The name of the node output.
    node_output_name: []const u8,

    /// The data type of the output field for compatibility validation.
    @"type": ?FlowNodeIODataType = null,

    pub const json_field_names = .{
        .content = "content",
        .next = "next",
        .node_output_name = "nodeOutputName",
        .@"type" = "type",
    };
};
