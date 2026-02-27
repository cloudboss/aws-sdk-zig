const KnowledgeBaseConfig = @import("knowledge_base_config.zig").KnowledgeBaseConfig;
const EvaluationPrecomputedRagSourceConfig = @import("evaluation_precomputed_rag_source_config.zig").EvaluationPrecomputedRagSourceConfig;

/// Contains configuration details for retrieval of information and response
/// generation.
pub const RAGConfig = union(enum) {
    /// Contains configuration details for knowledge base retrieval and response
    /// generation.
    knowledge_base_config: ?KnowledgeBaseConfig,
    /// Contains configuration details about the RAG source used to generate
    /// inference response data for a Knowledge Base evaluation job.
    precomputed_rag_source_config: ?EvaluationPrecomputedRagSourceConfig,

    pub const json_field_names = .{
        .knowledge_base_config = "knowledgeBaseConfig",
        .precomputed_rag_source_config = "precomputedRagSourceConfig",
    };
};
