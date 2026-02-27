/// Contains summary consolidation override configuration.
pub const SummaryConsolidationOverride = struct {
    /// The text to append to the prompt for summary consolidation.
    append_to_prompt: []const u8,

    /// The model ID to use for summary consolidation.
    model_id: []const u8,

    pub const json_field_names = .{
        .append_to_prompt = "appendToPrompt",
        .model_id = "modelId",
    };
};
