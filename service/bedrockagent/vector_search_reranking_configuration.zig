const VectorSearchBedrockRerankingConfiguration = @import("vector_search_bedrock_reranking_configuration.zig").VectorSearchBedrockRerankingConfiguration;
const VectorSearchRerankingConfigurationType = @import("vector_search_reranking_configuration_type.zig").VectorSearchRerankingConfigurationType;

/// Specifies how retrieved results from a knowledge base are reranked to
/// improve relevance.
pub const VectorSearchRerankingConfiguration = struct {
    /// Specifies the configuration for using an Amazon Bedrock reranker model to
    /// rerank retrieved results.
    bedrock_reranking_configuration: ?VectorSearchBedrockRerankingConfiguration = null,

    /// Specifies the type of reranking model to use. Currently, the only supported
    /// value is `BEDROCK_RERANKING_MODEL`.
    @"type": VectorSearchRerankingConfigurationType,

    pub const json_field_names = .{
        .bedrock_reranking_configuration = "bedrockRerankingConfiguration",
        .@"type" = "type",
    };
};
