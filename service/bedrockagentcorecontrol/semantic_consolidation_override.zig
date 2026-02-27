/// Contains semantic consolidation override configuration.
pub const SemanticConsolidationOverride = struct {
    /// The text to append to the prompt for semantic consolidation.
    append_to_prompt: []const u8,

    /// The model ID to use for semantic consolidation.
    model_id: []const u8,

    pub const json_field_names = .{
        .append_to_prompt = "appendToPrompt",
        .model_id = "modelId",
    };
};
