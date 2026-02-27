const FlowExecutionContent = @import("flow_execution_content.zig").FlowExecutionContent;

/// Represents an input field provided to a flow during a flow execution.
///
/// Flow executions is in preview release for Amazon Bedrock and is subject to
/// change.
pub const FlowInputField = struct {
    /// The content of the input field, which can contain text or structured data.
    content: FlowExecutionContent,

    /// The name of the input field as defined in the flow's input schema.
    name: []const u8,

    pub const json_field_names = .{
        .content = "content",
        .name = "name",
    };
};
