const EpisodicOverrideExtractionConfigurationInput = @import("episodic_override_extraction_configuration_input.zig").EpisodicOverrideExtractionConfigurationInput;
const SemanticOverrideExtractionConfigurationInput = @import("semantic_override_extraction_configuration_input.zig").SemanticOverrideExtractionConfigurationInput;
const UserPreferenceOverrideExtractionConfigurationInput = @import("user_preference_override_extraction_configuration_input.zig").UserPreferenceOverrideExtractionConfigurationInput;

/// Input for a custom extraction configuration.
pub const CustomExtractionConfigurationInput = union(enum) {
    /// Configurations to override the extraction step of the episodic strategy.
    episodic_extraction_override: ?EpisodicOverrideExtractionConfigurationInput,
    /// The semantic extraction override configuration input.
    semantic_extraction_override: ?SemanticOverrideExtractionConfigurationInput,
    /// The user preference extraction override configuration input.
    user_preference_extraction_override: ?UserPreferenceOverrideExtractionConfigurationInput,

    pub const json_field_names = .{
        .episodic_extraction_override = "episodicExtractionOverride",
        .semantic_extraction_override = "semanticExtractionOverride",
        .user_preference_extraction_override = "userPreferenceExtractionOverride",
    };
};
