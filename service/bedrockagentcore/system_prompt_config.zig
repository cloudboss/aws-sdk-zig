const SystemPromptConfigurationBundle = @import("system_prompt_configuration_bundle.zig").SystemPromptConfigurationBundle;

/// The system prompt input, either as inline text or from a configuration
/// bundle.
pub const SystemPromptConfig = union(enum) {
    /// The system prompt sourced from a configuration bundle version.
    configuration_bundle: ?SystemPromptConfigurationBundle,
    /// The system prompt text provided inline.
    text: ?[]const u8,

    pub const json_field_names = .{
        .configuration_bundle = "configurationBundle",
        .text = "text",
    };
};
