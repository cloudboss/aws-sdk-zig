const AgenticRetrieveBedrockRerankingModelConfiguration = @import("agentic_retrieve_bedrock_reranking_model_configuration.zig").AgenticRetrieveBedrockRerankingModelConfiguration;

/// Configuration for a Bedrock reranking model.
pub const AgenticRetrieveBedrockRerankingConfiguration = struct {
    /// The model configuration containing the model ARN.
    model_configuration: AgenticRetrieveBedrockRerankingModelConfiguration,

    pub const json_field_names = .{
        .model_configuration = "modelConfiguration",
    };
};
