const AnonymousUserDashboardEmbeddingConfigurationDisabledFeature = @import("anonymous_user_dashboard_embedding_configuration_disabled_feature.zig").AnonymousUserDashboardEmbeddingConfigurationDisabledFeature;
const AnonymousUserDashboardEmbeddingConfigurationEnabledFeature = @import("anonymous_user_dashboard_embedding_configuration_enabled_feature.zig").AnonymousUserDashboardEmbeddingConfigurationEnabledFeature;
const AnonymousUserDashboardFeatureConfigurations = @import("anonymous_user_dashboard_feature_configurations.zig").AnonymousUserDashboardFeatureConfigurations;

/// Information about the dashboard that you want to embed.
pub const AnonymousUserDashboardEmbeddingConfiguration = struct {
    /// A list of all disabled features of a specified anonymous dashboard.
    disabled_features: ?[]const AnonymousUserDashboardEmbeddingConfigurationDisabledFeature,

    /// A list of all enabled features of a specified anonymous dashboard.
    enabled_features: ?[]const AnonymousUserDashboardEmbeddingConfigurationEnabledFeature,

    /// The feature configuration for an embedded dashboard.
    feature_configurations: ?AnonymousUserDashboardFeatureConfigurations,

    /// The dashboard ID for the dashboard that you want the user to see first. This
    /// ID is
    /// included in the output URL. When the URL in response is accessed, Amazon
    /// Quick Sight
    /// renders this dashboard.
    ///
    /// The Amazon Resource Name (ARN) of this dashboard must be included in the
    /// `AuthorizedResourceArns` parameter. Otherwise, the request will fail with
    /// `InvalidParameterValueException`.
    initial_dashboard_id: []const u8,

    pub const json_field_names = .{
        .disabled_features = "DisabledFeatures",
        .enabled_features = "EnabledFeatures",
        .feature_configurations = "FeatureConfigurations",
        .initial_dashboard_id = "InitialDashboardId",
    };
};
