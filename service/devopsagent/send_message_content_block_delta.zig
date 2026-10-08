const SendMessageJsonDelta = @import("send_message_json_delta.zig").SendMessageJsonDelta;
const SendMessageTextDelta = @import("send_message_text_delta.zig").SendMessageTextDelta;

/// Union of possible delta payloads within a content block delta event
pub const SendMessageContentBlockDelta = union(enum) {
    /// JSON delta for structured content blocks
    json_delta: ?SendMessageJsonDelta,
    /// Text delta for text-based content blocks
    text_delta: ?SendMessageTextDelta,

    pub const json_field_names = .{
        .json_delta = "jsonDelta",
        .text_delta = "textDelta",
    };
};
