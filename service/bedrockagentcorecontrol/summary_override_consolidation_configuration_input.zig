/// Input for summary override consolidation configuration in a memory strategy.
pub const SummaryOverrideConsolidationConfigurationInput = struct {
    /// The text to append to the prompt for summary consolidation.
    append_to_prompt: []const u8,

    /// The model ID to use for summary consolidation.
    model_id: []const u8,

    pub const json_field_names = .{
        .append_to_prompt = "appendToPrompt",
        .model_id = "modelId",
    };
};
