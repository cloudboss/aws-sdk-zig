const BedrockFoundationModelContextEnrichmentConfiguration = @import("bedrock_foundation_model_context_enrichment_configuration.zig").BedrockFoundationModelContextEnrichmentConfiguration;
const ContextEnrichmentType = @import("context_enrichment_type.zig").ContextEnrichmentType;

/// Context enrichment configuration is used to provide additional context to
/// the RAG application.
pub const ContextEnrichmentConfiguration = struct {
    /// The configuration of the Amazon Bedrock foundation model used for context
    /// enrichment.
    bedrock_foundation_model_configuration: ?BedrockFoundationModelContextEnrichmentConfiguration = null,

    /// The method used for context enrichment. It must be Amazon Bedrock foundation
    /// models.
    @"type": ContextEnrichmentType,

    pub const json_field_names = .{
        .bedrock_foundation_model_configuration = "bedrockFoundationModelConfiguration",
        .@"type" = "type",
    };
};
