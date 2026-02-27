const EnrichmentStrategyConfiguration = @import("enrichment_strategy_configuration.zig").EnrichmentStrategyConfiguration;

/// Context enrichment configuration is used to provide additional context to
/// the RAG application using Amazon Bedrock foundation models.
pub const BedrockFoundationModelContextEnrichmentConfiguration = struct {
    /// The enrichment stategy used to provide additional context. For example,
    /// Neptune GraphRAG uses Amazon Bedrock foundation models to perform chunk
    /// entity extraction.
    enrichment_strategy_configuration: EnrichmentStrategyConfiguration,

    /// The Amazon Resource Name (ARN) of the model used to create vector embeddings
    /// for the knowledge base.
    model_arn: []const u8,

    pub const json_field_names = .{
        .enrichment_strategy_configuration = "enrichmentStrategyConfiguration",
        .model_arn = "modelArn",
    };
};
