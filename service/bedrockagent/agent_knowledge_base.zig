const KnowledgeBaseState = @import("knowledge_base_state.zig").KnowledgeBaseState;

/// Contains details about a knowledge base that is associated with an agent.
pub const AgentKnowledgeBase = struct {
    /// The unique identifier of the agent with which the knowledge base is
    /// associated.
    agent_id: []const u8,

    /// The version of the agent with which the knowledge base is associated.
    agent_version: []const u8,

    /// The time at which the association between the agent and the knowledge base
    /// was created.
    created_at: i64,

    /// The description of the association between the agent and the knowledge base.
    description: []const u8,

    /// The unique identifier of the association between the agent and the knowledge
    /// base.
    knowledge_base_id: []const u8,

    /// Specifies whether to use the knowledge base or not when sending an
    /// [InvokeAgent](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_InvokeAgent.html) request.
    knowledge_base_state: KnowledgeBaseState,

    /// The time at which the association between the agent and the knowledge base
    /// was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .agent_id = "agentId",
        .agent_version = "agentVersion",
        .created_at = "createdAt",
        .description = "description",
        .knowledge_base_id = "knowledgeBaseId",
        .knowledge_base_state = "knowledgeBaseState",
        .updated_at = "updatedAt",
    };
};
