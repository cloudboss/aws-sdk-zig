/// Contains configurations to override the default extraction step for the
/// episodic memory strategy.
pub const EpisodicExtractionOverride = struct {
    /// The text appended to the prompt for the extraction step of the episodic
    /// memory strategy.
    append_to_prompt: []const u8,

    /// The model ID used for the extraction step of the episodic memory strategy.
    model_id: []const u8,

    pub const json_field_names = .{
        .append_to_prompt = "appendToPrompt",
        .model_id = "modelId",
    };
};
