const ManagedSearchBedrockRerankingConfiguration = @import("managed_search_bedrock_reranking_configuration.zig").ManagedSearchBedrockRerankingConfiguration;
const ManagedSearchRerankingConfigurationType = @import("managed_search_reranking_configuration_type.zig").ManagedSearchRerankingConfigurationType;

/// Configuration for the reranking model used in managed search.
pub const ManagedSearchRerankingConfiguration = struct {
    /// The Bedrock reranking model configuration for managed search.
    bedrock_reranking_configuration: ?ManagedSearchBedrockRerankingConfiguration = null,

    /// The type of reranking configuration.
    type: ManagedSearchRerankingConfigurationType,

    pub const json_field_names = .{
        .bedrock_reranking_configuration = "bedrockRerankingConfiguration",
        .type = "type",
    };
};
