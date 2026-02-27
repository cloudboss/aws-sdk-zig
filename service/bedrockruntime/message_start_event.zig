const ConversationRole = @import("conversation_role.zig").ConversationRole;

/// The start of a message.
pub const MessageStartEvent = struct {
    /// The role for the message.
    role: ConversationRole,

    pub const json_field_names = .{
        .role = "role",
    };
};
