/// The source reference for an existing attachment in an existing conversation.
pub const ConversationSource = struct {
    /// The unique identifier of the Amazon Q Business attachment.
    attachment_id: []const u8,

    /// The unique identifier of the Amazon Q Business conversation.
    conversation_id: []const u8,

    pub const json_field_names = .{
        .attachment_id = "attachmentId",
        .conversation_id = "conversationId",
    };
};
