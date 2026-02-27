const ContentBlock = @import("content_block.zig").ContentBlock;
const ConversationRole = @import("conversation_role.zig").ConversationRole;

/// Details about a message.
pub const Message = struct {
    /// The message's content.
    content: []const ContentBlock,

    /// The message's role.
    role: ConversationRole,

    pub const json_field_names = .{
        .content = "content",
        .role = "role",
    };
};
