const MetadataConfigurationForReranking = @import("metadata_configuration_for_reranking.zig").MetadataConfigurationForReranking;
const VectorSearchBedrockRerankingModelConfiguration = @import("vector_search_bedrock_reranking_model_configuration.zig").VectorSearchBedrockRerankingModelConfiguration;

/// Configures the Amazon Bedrock reranker model to improve the relevance of
/// retrieved results.
pub const VectorSearchBedrockRerankingConfiguration = struct {
    /// Specifies how metadata fields should be handled during the reranking
    /// process.
    metadata_configuration: ?MetadataConfigurationForReranking = null,

    /// Specifies the configuration for the Amazon Bedrock reranker model.
    model_configuration: VectorSearchBedrockRerankingModelConfiguration,

    /// Specifies the number of results to return after reranking.
    number_of_reranked_results: ?i32 = null,

    pub const json_field_names = .{
        .metadata_configuration = "metadataConfiguration",
        .model_configuration = "modelConfiguration",
        .number_of_reranked_results = "numberOfRerankedResults",
    };
};
