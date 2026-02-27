const SpanTextValue = @import("span_text_value.zig").SpanTextValue;
const SpanToolResultValue = @import("span_tool_result_value.zig").SpanToolResultValue;
const SpanToolUseValue = @import("span_tool_use_value.zig").SpanToolUseValue;

/// Message content value - can be text, tool invocation, or tool result
pub const SpanMessageValue = union(enum) {
    /// Text message content
    text: ?SpanTextValue,
    /// Tool result message content
    tool_result: ?SpanToolResultValue,
    /// Tool invocation message content
    tool_use: ?SpanToolUseValue,

    pub const json_field_names = .{
        .text = "text",
        .tool_result = "toolResult",
        .tool_use = "toolUse",
    };
};
