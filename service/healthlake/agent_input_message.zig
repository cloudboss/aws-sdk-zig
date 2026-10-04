const AgentInputMessageType = @import("agent_input_message_type.zig").AgentInputMessageType;

/// Represents a message sent to the agent during chat-based profile
/// customization.
pub const AgentInputMessage = struct {
    /// The text of your message to the agent.
    body: []const u8,

    /// The type of input message, which determines how the agent processes your
    /// request. Valid values:
    ///
    /// * `normal`: A regular message to the agent.
    /// * `confirmation_response`: A response to a confirmation request from the
    ///   agent.
    @"type": AgentInputMessageType,

    pub const json_field_names = .{
        .body = "Body",
        .@"type" = "Type",
    };
};
