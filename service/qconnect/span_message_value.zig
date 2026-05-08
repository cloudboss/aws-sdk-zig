const SpanReasoningValue = @import("span_reasoning_value.zig").SpanReasoningValue;
const SpanTextValue = @import("span_text_value.zig").SpanTextValue;
const SpanToolResultValue = @import("span_tool_result_value.zig").SpanToolResultValue;
const SpanToolUseValue = @import("span_tool_use_value.zig").SpanToolUseValue;

/// Message content value - can be text, tool invocation, tool result, or
/// reasoning
pub const SpanMessageValue = union(enum) {
    reasoning: ?SpanReasoningValue,
    /// Text message content
    text: ?SpanTextValue,
    /// Tool result message content
    tool_result: ?SpanToolResultValue,
    /// Tool invocation message content
    tool_use: ?SpanToolUseValue,

    pub const json_field_names = .{
        .reasoning = "reasoning",
        .text = "text",
        .tool_result = "toolResult",
        .tool_use = "toolUse",
    };
};
