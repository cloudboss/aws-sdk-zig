const RetrievalFilter = @import("retrieval_filter.zig").RetrievalFilter;
const ImplicitFilterConfiguration = @import("implicit_filter_configuration.zig").ImplicitFilterConfiguration;
const SearchType = @import("search_type.zig").SearchType;
const VectorSearchRerankingConfiguration = @import("vector_search_reranking_configuration.zig").VectorSearchRerankingConfiguration;

/// The configuration details for returning the results from the knowledge base
/// vector search.
pub const KnowledgeBaseVectorSearchConfiguration = struct {
    /// Specifies the filters to use on the metadata fields in the knowledge base
    /// data sources before returning results.
    filter: ?RetrievalFilter = null,

    /// Configuration for implicit filtering in Knowledge Base vector searches. This
    /// allows the system to automatically apply filters based on the query context
    /// without requiring explicit filter expressions.
    implicit_filter_configuration: ?ImplicitFilterConfiguration = null,

    /// The number of text chunks to retrieve; the number of results to return.
    number_of_results: ?i32 = null,

    /// By default, Amazon Bedrock decides a search strategy for you. If you're
    /// using an Amazon OpenSearch Serverless vector store that contains a
    /// filterable text field, you can specify whether to query the knowledge base
    /// with a `HYBRID` search using both vector embeddings and raw text, or
    /// `SEMANTIC` search using only vector embeddings. For other vector store
    /// configurations, only `SEMANTIC` search is available.
    override_search_type: ?SearchType = null,

    /// Configuration for reranking search results in Knowledge Base vector
    /// searches. Reranking improves search relevance by reordering initial vector
    /// search results using more sophisticated relevance models.
    reranking_configuration: ?VectorSearchRerankingConfiguration = null,

    pub const json_field_names = .{
        .filter = "filter",
        .implicit_filter_configuration = "implicitFilterConfiguration",
        .number_of_results = "numberOfResults",
        .override_search_type = "overrideSearchType",
        .reranking_configuration = "rerankingConfiguration",
    };
};
