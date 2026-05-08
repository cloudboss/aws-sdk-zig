const LlmExtractionConfig = @import("llm_extraction_config.zig").LlmExtractionConfig;

/// Configuration for metadata extraction from conversational content.
pub const ExtractionConfig = union(enum) {
    /// Model-based extraction using a definition and instructions.
    llm_extraction_config: ?LlmExtractionConfig,

    pub const json_field_names = .{
        .llm_extraction_config = "llmExtractionConfig",
    };
};
