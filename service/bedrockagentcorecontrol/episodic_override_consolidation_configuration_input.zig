/// Configurations for overriding the consolidation step of the episodic memory
/// strategy.
pub const EpisodicOverrideConsolidationConfigurationInput = struct {
    /// The text to append to the prompt for the consolidation step of the episodic
    /// memory strategy.
    append_to_prompt: []const u8,

    /// The model ID to use for the consolidation step of the episodic memory
    /// strategy.
    model_id: []const u8,

    pub const json_field_names = .{
        .append_to_prompt = "appendToPrompt",
        .model_id = "modelId",
    };
};
