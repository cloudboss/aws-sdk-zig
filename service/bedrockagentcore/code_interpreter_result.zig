const ContentBlock = @import("content_block.zig").ContentBlock;
const ToolResultStructuredContent = @import("tool_result_structured_content.zig").ToolResultStructuredContent;

/// The output produced by executing code in a code interpreter session in
/// Amazon Bedrock AgentCore. This structure contains the results of code
/// execution, including textual output, structured data, and error information.
/// Agents use these results to generate responses that incorporate computation,
/// data analysis, and visualization.
pub const CodeInterpreterResult = struct {
    /// The textual content of the execution result. This includes standard output
    /// from the code execution, such as print statements, console output, and text
    /// representations of results.
    content: []const ContentBlock,

    /// Indicates whether the result represents an error. If true, the content
    /// contains error messages or exception information. If false, the content
    /// contains successful execution results.
    is_error: ?bool = null,

    /// The structured content of the execution result. This includes additional
    /// metadata about the execution, such as execution time, memory usage, and
    /// structured representations of output data. The format depends on the
    /// specific code interpreter and execution context.
    structured_content: ?ToolResultStructuredContent = null,

    pub const json_field_names = .{
        .content = "content",
        .is_error = "isError",
        .structured_content = "structuredContent",
    };
};
