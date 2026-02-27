const NodeInputField = @import("node_input_field.zig").NodeInputField;

/// Contains information about the inputs provided to a specific node during a
/// flow execution.
///
/// Flow executions is in preview release for Amazon Bedrock and is subject to
/// change.
pub const NodeInputEvent = struct {
    /// A list of input fields provided to the node.
    fields: []const NodeInputField,

    /// The name of the node that received the inputs.
    node_name: []const u8,

    /// The timestamp when the inputs were provided to the node.
    timestamp: i64,

    pub const json_field_names = .{
        .fields = "fields",
        .node_name = "nodeName",
        .timestamp = "timestamp",
    };
};
