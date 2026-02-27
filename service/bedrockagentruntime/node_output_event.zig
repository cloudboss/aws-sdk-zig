const NodeOutputField = @import("node_output_field.zig").NodeOutputField;

/// Contains information about the outputs produced by a specific node during a
/// flow execution.
///
/// Flow executions is in preview release for Amazon Bedrock and is subject to
/// change.
pub const NodeOutputEvent = struct {
    /// A list of output fields produced by the node.
    fields: []const NodeOutputField,

    /// The name of the node that produced the outputs.
    node_name: []const u8,

    /// The timestamp when the outputs were produced by the node.
    timestamp: i64,

    pub const json_field_names = .{
        .fields = "fields",
        .node_name = "nodeName",
        .timestamp = "timestamp",
    };
};
