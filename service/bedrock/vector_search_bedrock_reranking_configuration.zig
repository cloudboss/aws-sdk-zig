const MetadataConfigurationForReranking = @import("metadata_configuration_for_reranking.zig").MetadataConfigurationForReranking;
const VectorSearchBedrockRerankingModelConfiguration = @import("vector_search_bedrock_reranking_model_configuration.zig").VectorSearchBedrockRerankingModelConfiguration;

/// Configuration for using Amazon Bedrock foundation models to rerank Knowledge
/// Base vector search results. This enables more sophisticated relevance
/// ranking using large language models.
pub const VectorSearchBedrockRerankingConfiguration = struct {
    /// Configuration for how document metadata should be used during the reranking
    /// process. This determines which metadata fields are included when reordering
    /// search results.
    metadata_configuration: ?MetadataConfigurationForReranking,

    /// Configuration for the Amazon Bedrock foundation model used for reranking.
    /// This includes the model ARN and any additional request fields required by
    /// the model.
    model_configuration: VectorSearchBedrockRerankingModelConfiguration,

    /// The maximum number of results to rerank. This limits how many of the initial
    /// vector search results will be processed by the reranking model. A smaller
    /// number improves performance but may exclude potentially relevant results.
    number_of_reranked_results: ?i32,

    pub const json_field_names = .{
        .metadata_configuration = "metadataConfiguration",
        .model_configuration = "modelConfiguration",
        .number_of_reranked_results = "numberOfRerankedResults",
    };
};
