const RetrievalFilterConfiguration = @import("retrieval_filter_configuration.zig").RetrievalFilterConfiguration;
const KnowledgeSource = @import("knowledge_source.zig").KnowledgeSource;
const KnowledgeBaseSearchType = @import("knowledge_base_search_type.zig").KnowledgeBaseSearchType;

/// Configuration for content retrieval operations.
pub const RetrievalConfiguration = struct {
    /// The filter configuration for content retrieval.
    filter: ?RetrievalFilterConfiguration = null,

    /// The knowledge source configuration for content retrieval.
    knowledge_source: KnowledgeSource,

    /// The number of results to retrieve.
    number_of_results: ?i32 = null,

    /// Override setting for the knowledge base search type during retrieval.
    override_knowledge_base_search_type: ?KnowledgeBaseSearchType = null,

    pub const json_field_names = .{
        .filter = "filter",
        .knowledge_source = "knowledgeSource",
        .number_of_results = "numberOfResults",
        .override_knowledge_base_search_type = "overrideKnowledgeBaseSearchType",
    };
};
