const BedrockRerankingConfiguration = @import("bedrock_reranking_configuration.zig").BedrockRerankingConfiguration;
const RerankingConfigurationType = @import("reranking_configuration_type.zig").RerankingConfigurationType;

/// Contains configurations for reranking.
pub const RerankingConfiguration = struct {
    /// Contains configurations for an Amazon Bedrock reranker.
    bedrock_reranking_configuration: BedrockRerankingConfiguration,

    /// The type of reranker that the configurations apply to.
    type: RerankingConfigurationType,

    pub const json_field_names = .{
        .bedrock_reranking_configuration = "bedrockRerankingConfiguration",
        .type = "type",
    };
};
