const SelfServiceConversationHistory = @import("self_service_conversation_history.zig").SelfServiceConversationHistory;

/// The conversation context to include in SendMessage.
pub const ConversationContext = struct {
    /// The self service conversation history before the Amazon Q in Connect
    /// session.
    self_service_conversation_history: []const SelfServiceConversationHistory,

    pub const json_field_names = .{
        .self_service_conversation_history = "selfServiceConversationHistory",
    };
};
