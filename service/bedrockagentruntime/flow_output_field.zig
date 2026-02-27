const FlowExecutionContent = @import("flow_execution_content.zig").FlowExecutionContent;

/// Represents an output field produced by a flow during a flow execution.
///
/// Flow executions is in preview release for Amazon Bedrock and is subject to
/// change.
pub const FlowOutputField = struct {
    /// The content of the output field, which can contain text or structured data.
    content: FlowExecutionContent,

    /// The name of the output field as defined in the flow's output schema.
    name: []const u8,

    pub const json_field_names = .{
        .content = "content",
        .name = "name",
    };
};
