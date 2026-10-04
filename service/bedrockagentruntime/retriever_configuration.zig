const KnowledgeBaseRetrieverConfiguration = @import("knowledge_base_retriever_configuration.zig").KnowledgeBaseRetrieverConfiguration;

/// Configuration for a retriever, specified as a union of retriever types.
pub const RetrieverConfiguration = union(enum) {
    /// Configuration for a knowledge base retriever.
    knowledge_base: ?KnowledgeBaseRetrieverConfiguration,

    pub const json_field_names = .{
        .knowledge_base = "knowledgeBase",
    };
};
