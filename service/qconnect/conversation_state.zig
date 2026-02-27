const ConversationStatusReason = @import("conversation_status_reason.zig").ConversationStatusReason;
const ConversationStatus = @import("conversation_status.zig").ConversationStatus;

/// The conversation state associated to a message.
pub const ConversationState = struct {
    /// The reason of the conversation state.
    reason: ?ConversationStatusReason,

    /// The status of the conversation state.
    status: ConversationStatus,

    pub const json_field_names = .{
        .reason = "reason",
        .status = "status",
    };
};
