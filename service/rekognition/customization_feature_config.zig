const CustomizationFeatureContentModerationConfig = @import("customization_feature_content_moderation_config.zig").CustomizationFeatureContentModerationConfig;

/// Feature specific configuration for the training job. Configuration provided
/// for the job must match
/// the feature type parameter associated with project. If configuration
/// and feature type do not match an InvalidParameterException is returned.
pub const CustomizationFeatureConfig = struct {
    /// Configuration options for Custom Moderation training.
    content_moderation: ?CustomizationFeatureContentModerationConfig = null,

    pub const json_field_names = .{
        .content_moderation = "ContentModeration",
    };
};
