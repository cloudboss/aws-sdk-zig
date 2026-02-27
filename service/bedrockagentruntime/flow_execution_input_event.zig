const FlowInputField = @import("flow_input_field.zig").FlowInputField;

/// Contains information about the inputs provided to the flow at the start of a
/// flow execution.
///
/// Flow executions is in preview release for Amazon Bedrock and is subject to
/// change.
pub const FlowExecutionInputEvent = struct {
    /// A list of input fields provided to the flow.
    fields: []const FlowInputField,

    /// The name of the node that receives the inputs.
    node_name: []const u8,

    /// The timestamp when the inputs are provided.
    timestamp: i64,

    pub const json_field_names = .{
        .fields = "fields",
        .node_name = "nodeName",
        .timestamp = "timestamp",
    };
};
