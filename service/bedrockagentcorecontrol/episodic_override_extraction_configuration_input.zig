/// Configurations for overriding the extraction step of the episodic memory
/// strategy.
pub const EpisodicOverrideExtractionConfigurationInput = struct {
    /// The text to append to the prompt for the extraction step of the episodic
    /// memory strategy.
    append_to_prompt: []const u8,

    /// The model ID to use for the extraction step of the episodic memory strategy.
    model_id: []const u8,

    pub const json_field_names = .{
        .append_to_prompt = "appendToPrompt",
        .model_id = "modelId",
    };
};
