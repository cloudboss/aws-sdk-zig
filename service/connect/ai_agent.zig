const AIAgentType = @import("ai_agent_type.zig").AIAgentType;

/// Information about an AI agent that a security profile allows access to for
/// Agent-to-Agent authorization.
pub const AIAgent = struct {
    /// The Amazon Resource Name (ARN) of the AI agent.
    arn: ?[]const u8 = null,

    /// The type of the AI agent. The valid value is `THIRD_PARTY`.
    type: ?AIAgentType = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .type = "Type",
    };
};
