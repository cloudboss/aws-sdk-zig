const RetrievalFilter = @import("retrieval_filter.zig").RetrievalFilter;
const ImplicitFilterConfiguration = @import("implicit_filter_configuration.zig").ImplicitFilterConfiguration;
const SearchType = @import("search_type.zig").SearchType;
const VectorSearchRerankingConfiguration = @import("vector_search_reranking_configuration.zig").VectorSearchRerankingConfiguration;

/// Configurations for how to perform the search query and return results. For
/// more information, see [Query
/// configurations](https://docs.aws.amazon.com/bedrock/latest/userguide/kb-test-config.html).
///
/// This data type is used in the following API operations:
///
/// * [Retrieve
///   request](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_Retrieve.html#API_agent-runtime_Retrieve_RequestSyntax) – in the `vectorSearchConfiguration` field
/// * [RetrieveAndGenerate
///   request](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_RetrieveAndGenerate.html#API_agent-runtime_RetrieveAndGenerate_RequestSyntax) – in the `vectorSearchConfiguration` field
pub const KnowledgeBaseVectorSearchConfiguration = struct {
    /// Specifies the filters to use on the metadata in the knowledge base data
    /// sources before returning results. For more information, see [Query
    /// configurations](https://docs.aws.amazon.com/bedrock/latest/userguide/kb-test-config.html).
    filter: ?RetrievalFilter = null,

    /// Settings for implicit filtering.
    implicit_filter_configuration: ?ImplicitFilterConfiguration = null,

    /// The number of source chunks to retrieve.
    number_of_results: i32 = 5,

    /// By default, Amazon Bedrock decides a search strategy for you. If you're
    /// using an Amazon OpenSearch Serverless vector store that contains a
    /// filterable text field, you can specify whether to query the knowledge base
    /// with a `HYBRID` search using both vector embeddings and raw text, or
    /// `SEMANTIC` search using only vector embeddings. For other vector store
    /// configurations, only `SEMANTIC` search is available. For more information,
    /// see [Test a knowledge
    /// base](https://docs.aws.amazon.com/bedrock/latest/userguide/knowledge-base-test.html).
    override_search_type: ?SearchType = null,

    /// Contains configurations for reranking the retrieved results. For more
    /// information, see [Improve the relevance of query responses with a reranker
    /// model](https://docs.aws.amazon.com/bedrock/latest/userguide/rerank.html).
    reranking_configuration: ?VectorSearchRerankingConfiguration = null,

    pub const json_field_names = .{
        .filter = "filter",
        .implicit_filter_configuration = "implicitFilterConfiguration",
        .number_of_results = "numberOfResults",
        .override_search_type = "overrideSearchType",
        .reranking_configuration = "rerankingConfiguration",
    };
};
