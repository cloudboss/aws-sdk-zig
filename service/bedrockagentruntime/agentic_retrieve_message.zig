const AgenticRetrieveMessageContent = @import("agentic_retrieve_message_content.zig").AgenticRetrieveMessageContent;
const ConversationRole = @import("conversation_role.zig").ConversationRole;

/// A message in the agentic retrieval conversation.
pub const AgenticRetrieveMessage = struct {
    /// The content of the message.
    content: AgenticRetrieveMessageContent,

    /// The role of the message sender (e.g., user or assistant).
    role: ConversationRole,

    pub const json_field_names = .{
        .content = "content",
        .role = "role",
    };
};
