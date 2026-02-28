const NodeExecutionContent = @import("node_execution_content.zig").NodeExecutionContent;
const NodeOutputNext = @import("node_output_next.zig").NodeOutputNext;
const FlowNodeIODataType = @import("flow_node_io_data_type.zig").FlowNodeIODataType;

/// Represents an output field produced by a node during a flow execution.
///
/// Flow executions is in preview release for Amazon Bedrock and is subject to
/// change.
pub const NodeOutputField = struct {
    /// The content of the output field, which can contain text or structured data.
    content: NodeExecutionContent,

    /// The name of the output field as defined in the node's output schema.
    name: []const u8,

    /// The next node that receives output data from this field.
    next: ?[]const NodeOutputNext,

    /// The data type of the output field for compatibility validation.
    type: ?FlowNodeIODataType,

    pub const json_field_names = .{
        .content = "content",
        .name = "name",
        .next = "next",
        .type = "type",
    };
};
