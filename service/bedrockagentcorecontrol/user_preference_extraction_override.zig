/// Contains user preference extraction override configuration.
pub const UserPreferenceExtractionOverride = struct {
    /// The text to append to the prompt for user preference extraction.
    append_to_prompt: []const u8,

    /// The model ID to use for user preference extraction.
    model_id: []const u8,

    pub const json_field_names = .{
        .append_to_prompt = "appendToPrompt",
        .model_id = "modelId",
    };
};
