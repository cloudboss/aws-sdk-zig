const BedrockRerankingModelConfiguration = @import("bedrock_reranking_model_configuration.zig").BedrockRerankingModelConfiguration;

/// Contains configurations for an Amazon Bedrock reranker model.
pub const BedrockRerankingConfiguration = struct {
    /// Contains configurations for a reranker model.
    model_configuration: BedrockRerankingModelConfiguration,

    /// The number of results to return after reranking.
    number_of_results: ?i32,

    pub const json_field_names = .{
        .model_configuration = "modelConfiguration",
        .number_of_results = "numberOfResults",
    };
};
