const KnowledgeBaseRetrievalConfiguration = @import("knowledge_base_retrieval_configuration.zig").KnowledgeBaseRetrievalConfiguration;

/// The configuration details for retrieving information from a knowledge base.
pub const RetrieveConfig = struct {
    /// The unique identifier of the knowledge base.
    knowledge_base_id: []const u8,

    /// Contains configuration details for knowledge base retrieval.
    knowledge_base_retrieval_configuration: KnowledgeBaseRetrievalConfiguration,

    pub const json_field_names = .{
        .knowledge_base_id = "knowledgeBaseId",
        .knowledge_base_retrieval_configuration = "knowledgeBaseRetrievalConfiguration",
    };
};
