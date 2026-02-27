const VectorSearchBedrockRerankingConfiguration = @import("vector_search_bedrock_reranking_configuration.zig").VectorSearchBedrockRerankingConfiguration;
const VectorSearchRerankingConfigurationType = @import("vector_search_reranking_configuration_type.zig").VectorSearchRerankingConfigurationType;

/// Contains configurations for reranking the retrieved results.
pub const VectorSearchRerankingConfiguration = struct {
    /// Contains configurations for an Amazon Bedrock reranker model.
    bedrock_reranking_configuration: ?VectorSearchBedrockRerankingConfiguration,

    /// The type of reranker model.
    @"type": VectorSearchRerankingConfigurationType,

    pub const json_field_names = .{
        .bedrock_reranking_configuration = "bedrockRerankingConfiguration",
        .@"type" = "type",
    };
};
