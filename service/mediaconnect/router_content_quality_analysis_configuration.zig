const ContentQualityAnalysisFeatureConfiguration = @import("content_quality_analysis_feature_configuration.zig").ContentQualityAnalysisFeatureConfiguration;

/// The content quality analysis configuration for the router input.
///
/// The content quality analysis feature only monitors the first video stream
/// and the first audio stream it encounters within the router input source.
pub const RouterContentQualityAnalysisConfiguration = union(enum) {
    /// The content quality analysis configuration.
    content_level: ?ContentQualityAnalysisFeatureConfiguration,

    pub const json_field_names = .{
        .content_level = "ContentLevel",
    };
};
