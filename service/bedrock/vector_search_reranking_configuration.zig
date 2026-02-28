const VectorSearchBedrockRerankingConfiguration = @import("vector_search_bedrock_reranking_configuration.zig").VectorSearchBedrockRerankingConfiguration;
const VectorSearchRerankingConfigurationType = @import("vector_search_reranking_configuration_type.zig").VectorSearchRerankingConfigurationType;

/// Configuration for reranking vector search results to improve relevance.
/// Reranking applies additional relevance models to reorder the initial vector
/// search results based on more sophisticated criteria.
pub const VectorSearchRerankingConfiguration = struct {
    /// Configuration for using Amazon Bedrock foundation models to rerank search
    /// results. This is required when the reranking type is set to BEDROCK.
    bedrock_reranking_configuration: ?VectorSearchBedrockRerankingConfiguration,

    /// The type of reranking to apply to vector search results. Currently, the only
    /// supported value is BEDROCK, which uses Amazon Bedrock foundation models for
    /// reranking.
    @"type": VectorSearchRerankingConfigurationType,

    pub const json_field_names = .{
        .bedrock_reranking_configuration = "bedrockRerankingConfiguration",
        .@"type" = "type",
    };
};
