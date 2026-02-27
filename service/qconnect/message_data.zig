const TextMessage = @import("text_message.zig").TextMessage;
const ToolUseResultData = @import("tool_use_result_data.zig").ToolUseResultData;

/// The message data.
pub const MessageData = union(enum) {
    /// The message data in text type.
    text: ?TextMessage,
    /// The result of tool usage in the message.
    tool_use_result: ?ToolUseResultData,

    pub const json_field_names = .{
        .text = "text",
        .tool_use_result = "toolUseResult",
    };
};
