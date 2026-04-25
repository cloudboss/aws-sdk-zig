const HarnessContentBlock = @import("harness_content_block.zig").HarnessContentBlock;
const HarnessConversationRole = @import("harness_conversation_role.zig").HarnessConversationRole;

/// A message in the conversation.
pub const HarnessMessage = struct {
    /// The content blocks of the message.
    content: []const HarnessContentBlock,

    /// The role of the message sender.
    role: HarnessConversationRole,

    pub const json_field_names = .{
        .content = "content",
        .role = "role",
    };
};
