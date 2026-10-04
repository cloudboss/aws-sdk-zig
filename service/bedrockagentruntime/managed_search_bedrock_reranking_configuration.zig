const MetadataConfigurationForReranking = @import("metadata_configuration_for_reranking.zig").MetadataConfigurationForReranking;
const ManagedSearchBedrockRerankingModelConfiguration = @import("managed_search_bedrock_reranking_model_configuration.zig").ManagedSearchBedrockRerankingModelConfiguration;

/// Configuration for a Bedrock reranking model used in managed search.
pub const ManagedSearchBedrockRerankingConfiguration = struct {
    /// The metadata configuration for reranking.
    metadata_configuration: ?MetadataConfigurationForReranking = null,

    /// The model configuration containing the model ARN for reranking.
    model_configuration: ManagedSearchBedrockRerankingModelConfiguration,

    /// The number of results to return after reranking.
    number_of_reranked_results: ?i32 = null,

    pub const json_field_names = .{
        .metadata_configuration = "metadataConfiguration",
        .model_configuration = "modelConfiguration",
        .number_of_reranked_results = "numberOfRerankedResults",
    };
};
