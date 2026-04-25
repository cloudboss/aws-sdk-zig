/// Contains configurations to override the default reflection step for the
/// episodic memory strategy.
pub const EpisodicReflectionOverride = struct {
    /// The text appended to the prompt for the reflection step of the episodic
    /// memory strategy.
    append_to_prompt: []const u8,

    /// The model ID used for the reflection step of the episodic memory strategy.
    model_id: []const u8,

    /// The namespaces over which reflections were created. Can be less nested than
    /// the episodic namespaces.
    namespaces: ?[]const []const u8 = null,

    /// The namespaceTemplates over which reflections were created. Can be less
    /// nested than the episodic namespaces.
    namespace_templates: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .append_to_prompt = "appendToPrompt",
        .model_id = "modelId",
        .namespaces = "namespaces",
        .namespace_templates = "namespaceTemplates",
    };
};
