const TextMessage = @import("text_message.zig").TextMessage;
const ToolUseResultData = @import("tool_use_result_data.zig").ToolUseResultData;

/// The message data.
pub const MessageData = union(enum) {
    /// The message data as a structured JSON document. This is the payload for a
    /// message of type `DATA`, and must be a JSON object at the root level.
    data: ?[]const u8,
    /// The message data in text type.
    text: ?TextMessage,
    /// The result of tool usage in the message.
    tool_use_result: ?ToolUseResultData,

    pub const json_field_names = .{
        .data = "data",
        .text = "text",
        .tool_use_result = "toolUseResult",
    };
};
