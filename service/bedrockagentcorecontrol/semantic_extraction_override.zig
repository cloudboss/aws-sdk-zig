/// Contains semantic extraction override configuration.
pub const SemanticExtractionOverride = struct {
    /// The text to append to the prompt for semantic extraction.
    append_to_prompt: []const u8,

    /// The model ID to use for semantic extraction.
    model_id: []const u8,

    pub const json_field_names = .{
        .append_to_prompt = "appendToPrompt",
        .model_id = "modelId",
    };
};
