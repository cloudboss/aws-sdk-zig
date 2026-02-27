/// Input for user preference override consolidation configuration in a memory
/// strategy.
pub const UserPreferenceOverrideConsolidationConfigurationInput = struct {
    /// The text to append to the prompt for user preference consolidation.
    append_to_prompt: []const u8,

    /// The model ID to use for user preference consolidation.
    model_id: []const u8,

    pub const json_field_names = .{
        .append_to_prompt = "appendToPrompt",
        .model_id = "modelId",
    };
};
