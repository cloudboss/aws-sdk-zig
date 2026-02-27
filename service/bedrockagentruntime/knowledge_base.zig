const KnowledgeBaseRetrievalConfiguration = @import("knowledge_base_retrieval_configuration.zig").KnowledgeBaseRetrievalConfiguration;

/// Details of the knowledge base associated withe inline agent.
pub const KnowledgeBase = struct {
    /// The description of the knowledge base associated with the inline agent.
    description: []const u8,

    /// The unique identifier for a knowledge base associated with the inline agent.
    knowledge_base_id: []const u8,

    /// The configurations to apply to the knowledge base during query. For more
    /// information, see [Query
    /// configurations](https://docs.aws.amazon.com/bedrock/latest/userguide/kb-test-config.html).
    retrieval_configuration: ?KnowledgeBaseRetrievalConfiguration,

    pub const json_field_names = .{
        .description = "description",
        .knowledge_base_id = "knowledgeBaseId",
        .retrieval_configuration = "retrievalConfiguration",
    };
};
