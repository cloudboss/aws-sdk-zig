const FlowTraceNodeOutputField = @import("flow_trace_node_output_field.zig").FlowTraceNodeOutputField;

/// Contains information about the output from a node. For more information, see
/// [Track each step in your prompt flow by viewing its trace in Amazon
/// Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/flows-trace.html).
pub const FlowTraceNodeOutputEvent = struct {
    /// An array of objects containing information about each field in the output.
    fields: []const FlowTraceNodeOutputField,

    /// The name of the node that yielded the output.
    node_name: []const u8,

    /// The date and time that the trace was returned.
    timestamp: i64,

    pub const json_field_names = .{
        .fields = "fields",
        .node_name = "nodeName",
        .timestamp = "timestamp",
    };
};
