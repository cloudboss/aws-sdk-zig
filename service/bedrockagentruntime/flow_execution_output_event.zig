const FlowOutputField = @import("flow_output_field.zig").FlowOutputField;

/// Contains information about the outputs produced by the flow during a flow
/// execution.
///
/// Flow executions is in preview release for Amazon Bedrock and is subject to
/// change.
pub const FlowExecutionOutputEvent = struct {
    /// A list of output fields produced by the flow.
    fields: []const FlowOutputField,

    /// The name of the node that produces the outputs.
    node_name: []const u8,

    /// The timestamp when the outputs are produced.
    timestamp: i64,

    pub const json_field_names = .{
        .fields = "fields",
        .node_name = "nodeName",
        .timestamp = "timestamp",
    };
};
