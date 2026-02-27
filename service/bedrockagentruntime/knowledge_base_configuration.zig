const KnowledgeBaseRetrievalConfiguration = @import("knowledge_base_retrieval_configuration.zig").KnowledgeBaseRetrievalConfiguration;

/// Configurations to apply to a knowledge base attached to the agent during
/// query. For more information, see [Knowledge base retrieval
/// configurations](https://docs.aws.amazon.com/bedrock/latest/userguide/agents-session-state.html#session-state-kb).
pub const KnowledgeBaseConfiguration = struct {
    /// The unique identifier for a knowledge base attached to the agent.
    knowledge_base_id: []const u8,

    /// The configurations to apply to the knowledge base during query. For more
    /// information, see [Query
    /// configurations](https://docs.aws.amazon.com/bedrock/latest/userguide/kb-test-config.html).
    retrieval_configuration: KnowledgeBaseRetrievalConfiguration,

    pub const json_field_names = .{
        .knowledge_base_id = "knowledgeBaseId",
        .retrieval_configuration = "retrievalConfiguration",
    };
};
