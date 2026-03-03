const KnowledgeBaseState = @import("knowledge_base_state.zig").KnowledgeBaseState;

/// Contains details about a knowledge base associated with an agent.
pub const AgentKnowledgeBaseSummary = struct {
    /// The description of the knowledge base associated with an agent.
    description: ?[]const u8 = null,

    /// The unique identifier of the knowledge base associated with an agent.
    knowledge_base_id: []const u8,

    /// Specifies whether the agent uses the knowledge base or not when sending an
    /// [InvokeAgent](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_InvokeAgent.html) request.
    knowledge_base_state: KnowledgeBaseState,

    /// The time at which the knowledge base associated with an agent was last
    /// updated.
    updated_at: i64,

    pub const json_field_names = .{
        .description = "description",
        .knowledge_base_id = "knowledgeBaseId",
        .knowledge_base_state = "knowledgeBaseState",
        .updated_at = "updatedAt",
    };
};
