/// Configurations for overriding the reflection step of the episodic memory
/// strategy.
pub const EpisodicOverrideReflectionConfigurationInput = struct {
    /// The text to append to the prompt for reflection step of the episodic memory
    /// strategy.
    append_to_prompt: []const u8,

    /// The model ID to use for the reflection step of the episodic memory strategy.
    model_id: []const u8,

    /// The namespaces to use for episodic reflection. Can be less nested than the
    /// episodic namespaces.
    namespaces: ?[]const []const u8,

    pub const json_field_names = .{
        .append_to_prompt = "appendToPrompt",
        .model_id = "modelId",
        .namespaces = "namespaces",
    };
};
