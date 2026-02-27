const SystemMessageType = @import("system_message_type.zig").SystemMessageType;

/// An output event for an AI-generated response in an Amazon Q Business web
/// experience.
pub const TextOutputEvent = struct {
    /// The identifier of the conversation with which the text output event is
    /// associated.
    conversation_id: ?[]const u8,

    /// An AI-generated message in a `TextOutputEvent`.
    system_message: ?[]const u8,

    /// The identifier of an AI-generated message in a `TextOutputEvent`.
    system_message_id: ?[]const u8,

    /// The type of AI-generated message in a `TextOutputEvent`. Amazon Q Business
    /// currently supports two types of messages:
    ///
    /// * `RESPONSE` - The Amazon Q Business system response.
    /// * `GROUNDED_RESPONSE` - The corrected, hallucination-reduced, response
    ///   returned by Amazon Q Business. Available only if hallucination reduction
    ///   is supported and configured for the application and detected in the end
    ///   user chat query by Amazon Q Business.
    system_message_type: ?SystemMessageType,

    /// The identifier of an end user message in a `TextOutputEvent`.
    user_message_id: ?[]const u8,

    pub const json_field_names = .{
        .conversation_id = "conversationId",
        .system_message = "systemMessage",
        .system_message_id = "systemMessageId",
        .system_message_type = "systemMessageType",
        .user_message_id = "userMessageId",
    };
};
