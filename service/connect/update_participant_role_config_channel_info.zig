const ChatParticipantRoleConfig = @import("chat_participant_role_config.zig").ChatParticipantRoleConfig;

/// Configuration information for the chat participant role.
pub const UpdateParticipantRoleConfigChannelInfo = union(enum) {
    /// Configuration information for the chat participant role.
    chat: ?ChatParticipantRoleConfig,

    pub const json_field_names = .{
        .chat = "Chat",
    };
};
