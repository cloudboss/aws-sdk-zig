const ConversationSource = @import("conversation_source.zig").ConversationSource;

/// The source reference for an existing attachment.
pub const CopyFromSource = union(enum) {
    /// A reference to an attachment in an existing conversation.
    conversation: ?ConversationSource,

    pub const json_field_names = .{
        .conversation = "conversation",
    };
};
