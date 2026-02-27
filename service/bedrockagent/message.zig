const ContentBlock = @import("content_block.zig").ContentBlock;
const ConversationRole = @import("conversation_role.zig").ConversationRole;

/// A message input or response from a model. For more information, see [Create
/// a prompt using Prompt
/// management](https://docs.aws.amazon.com/bedrock/latest/userguide/prompt-management-create.html).
pub const Message = struct {
    /// The content in the message.
    content: []const ContentBlock,

    /// The role that the message belongs to.
    role: ConversationRole,

    pub const json_field_names = .{
        .content = "content",
        .role = "role",
    };
};
