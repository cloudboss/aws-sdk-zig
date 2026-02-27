const FlowTraceNodeInputField = @import("flow_trace_node_input_field.zig").FlowTraceNodeInputField;

/// Contains information about the input into a node. For more information, see
/// [Track each step in your prompt flow by viewing its trace in Amazon
/// Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/flows-trace.html).
pub const FlowTraceNodeInputEvent = struct {
    /// An array of objects containing information about each field in the input.
    fields: []const FlowTraceNodeInputField,

    /// The name of the node that received the input.
    node_name: []const u8,

    /// The date and time that the trace was returned.
    timestamp: i64,

    pub const json_field_names = .{
        .fields = "fields",
        .node_name = "nodeName",
        .timestamp = "timestamp",
    };
};
