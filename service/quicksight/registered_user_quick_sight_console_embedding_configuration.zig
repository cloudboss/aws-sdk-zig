const RegisteredUserConsoleFeatureConfigurations = @import("registered_user_console_feature_configurations.zig").RegisteredUserConsoleFeatureConfigurations;

/// Information about the Amazon Quick Sight console that you want to embed.
pub const RegisteredUserQuickSightConsoleEmbeddingConfiguration = struct {
    /// The embedding configuration of an embedded Amazon Quick Sight console.
    feature_configurations: ?RegisteredUserConsoleFeatureConfigurations = null,

    /// The initial URL path for the Amazon Quick Sight console. `InitialPath` is
    /// required.
    ///
    /// The entry point URL is constrained to the following paths:
    ///
    /// * `/start`
    ///
    /// * `/start/analyses`
    ///
    /// * `/start/dashboards`
    ///
    /// * `/start/favorites`
    ///
    /// * `/dashboards/DashboardId`. *DashboardId* is the
    /// actual ID key from the Amazon Quick Sight console URL of the dashboard.
    ///
    /// * `/analyses/AnalysisId`. *AnalysisId* is the
    /// actual ID key from the Amazon Quick Sight console URL of the analysis.
    initial_path: ?[]const u8 = null,

    pub const json_field_names = .{
        .feature_configurations = "FeatureConfigurations",
        .initial_path = "InitialPath",
    };
};
