const AssistantMessageBlock = @import("assistant_message_block.zig").AssistantMessageBlock;
const UserMessageBlock = @import("user_message_block.zig").UserMessageBlock;

/// A message in a conversation, either from the user or the assistant.
pub const Message = union(enum) {
    /// A message from the assistant.
    assistant_message: ?[]const AssistantMessageBlock,
    /// A message from the user.
    user_message: ?[]const UserMessageBlock,

    pub const json_field_names = .{
        .assistant_message = "assistantMessage",
        .user_message = "userMessage",
    };
};
