const MetadataConfigurationForReranking = @import("metadata_configuration_for_reranking.zig").MetadataConfigurationForReranking;
const VectorSearchBedrockRerankingModelConfiguration = @import("vector_search_bedrock_reranking_model_configuration.zig").VectorSearchBedrockRerankingModelConfiguration;

/// Contains configurations for reranking with an Amazon Bedrock reranker model.
pub const VectorSearchBedrockRerankingConfiguration = struct {
    /// Contains configurations for the metadata to use in reranking.
    metadata_configuration: ?MetadataConfigurationForReranking = null,

    /// Contains configurations for the reranker model.
    model_configuration: VectorSearchBedrockRerankingModelConfiguration,

    /// The number of results to return after reranking.
    number_of_reranked_results: ?i32 = null,

    pub const json_field_names = .{
        .metadata_configuration = "metadataConfiguration",
        .model_configuration = "modelConfiguration",
        .number_of_reranked_results = "numberOfRerankedResults",
    };
};
