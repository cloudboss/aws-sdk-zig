const HarnessConversationRole = @import("harness_conversation_role.zig").HarnessConversationRole;

/// Event indicating the start of a message.
pub const HarnessMessageStartEvent = struct {
    /// The role of the message sender.
    role: HarnessConversationRole,

    pub const json_field_names = .{
        .role = "role",
    };
};
