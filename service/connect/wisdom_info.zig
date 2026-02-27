const AiAgentInfo = @import("ai_agent_info.zig").AiAgentInfo;

/// Information about Amazon Connect Wisdom.
pub const WisdomInfo = struct {
    /// The array of AI agents involved in the contact.
    ai_agents: ?[]const AiAgentInfo,

    /// The Amazon Resource Name (ARN) of the Wisdom session.
    session_arn: ?[]const u8,

    pub const json_field_names = .{
        .ai_agents = "AiAgents",
        .session_arn = "SessionArn",
    };
};
