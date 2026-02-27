const EpisodicExtractionOverride = @import("episodic_extraction_override.zig").EpisodicExtractionOverride;
const SemanticExtractionOverride = @import("semantic_extraction_override.zig").SemanticExtractionOverride;
const UserPreferenceExtractionOverride = @import("user_preference_extraction_override.zig").UserPreferenceExtractionOverride;

/// Contains custom extraction configuration information.
pub const CustomExtractionConfiguration = union(enum) {
    /// The configurations to override the default extraction step for the episodic
    /// memory strategy.
    episodic_extraction_override: ?EpisodicExtractionOverride,
    /// The semantic extraction override configuration.
    semantic_extraction_override: ?SemanticExtractionOverride,
    /// The user preference extraction override configuration.
    user_preference_extraction_override: ?UserPreferenceExtractionOverride,

    pub const json_field_names = .{
        .episodic_extraction_override = "episodicExtractionOverride",
        .semantic_extraction_override = "semanticExtractionOverride",
        .user_preference_extraction_override = "userPreferenceExtractionOverride",
    };
};
