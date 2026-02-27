const ParticipantMetrics = @import("participant_metrics.zig").ParticipantMetrics;
const ChatContactMetrics = @import("chat_contact_metrics.zig").ChatContactMetrics;

/// Information about how agent, bot, and customer interact in a chat contact.
pub const ChatMetrics = struct {
    /// Information about agent interactions in a contact.
    agent_metrics: ?ParticipantMetrics,

    /// Information about the overall participant interactions at the contact level.
    chat_contact_metrics: ?ChatContactMetrics,

    /// Information about customer interactions in a contact.
    customer_metrics: ?ParticipantMetrics,

    pub const json_field_names = .{
        .agent_metrics = "AgentMetrics",
        .chat_contact_metrics = "ChatContactMetrics",
        .customer_metrics = "CustomerMetrics",
    };
};
