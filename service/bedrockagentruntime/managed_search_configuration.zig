const RetrievalFilter = @import("retrieval_filter.zig").RetrievalFilter;
const ManagedSearchRerankingConfiguration = @import("managed_search_reranking_configuration.zig").ManagedSearchRerankingConfiguration;
const RerankingModelType = @import("reranking_model_type.zig").RerankingModelType;

/// Configuration for managed search in a knowledge base. Managed search
/// automatically determines the best search strategy based on your data store
/// configuration.
pub const ManagedSearchConfiguration = struct {
    /// Filters the metadata of the retrieved results so that Amazon Bedrock returns
    /// only results that match the filter.
    filter: ?RetrievalFilter = null,

    /// The number of results to retrieve.
    number_of_results: ?i32 = null,

    /// Contains configurations for reranking the results retrieved from the managed
    /// search.
    reranking_configuration: ?ManagedSearchRerankingConfiguration = null,

    /// The type of reranking model to use when reranking results retrieved from the
    /// managed search. Use `CUSTOM` to specify a model, `MANAGED` to use the
    /// service default, or `NONE` to disable reranking.
    reranking_model_type: ?RerankingModelType = null,

    pub const json_field_names = .{
        .filter = "filter",
        .number_of_results = "numberOfResults",
        .reranking_configuration = "rerankingConfiguration",
        .reranking_model_type = "rerankingModelType",
    };
};
