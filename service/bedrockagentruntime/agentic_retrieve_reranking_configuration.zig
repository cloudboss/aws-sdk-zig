const AgenticRetrieveBedrockRerankingConfiguration = @import("agentic_retrieve_bedrock_reranking_configuration.zig").AgenticRetrieveBedrockRerankingConfiguration;
const AgenticRetrieveRerankingConfigurationType = @import("agentic_retrieve_reranking_configuration_type.zig").AgenticRetrieveRerankingConfigurationType;

/// Configuration for the reranking model.
pub const AgenticRetrieveRerankingConfiguration = struct {
    /// The Bedrock reranking model configuration.
    bedrock_reranking_configuration: ?AgenticRetrieveBedrockRerankingConfiguration = null,

    /// The type of reranking configuration.
    type: AgenticRetrieveRerankingConfigurationType,

    pub const json_field_names = .{
        .bedrock_reranking_configuration = "bedrockRerankingConfiguration",
        .type = "type",
    };
};
