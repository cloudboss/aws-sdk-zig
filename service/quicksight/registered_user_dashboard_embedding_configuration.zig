const RegisteredUserDashboardFeatureConfigurations = @import("registered_user_dashboard_feature_configurations.zig").RegisteredUserDashboardFeatureConfigurations;

/// Information about the dashboard you want to embed.
pub const RegisteredUserDashboardEmbeddingConfiguration = struct {
    /// The feature configurations of an embbedded Amazon Quick Sight dashboard.
    feature_configurations: ?RegisteredUserDashboardFeatureConfigurations,

    /// The dashboard ID for the dashboard that you want the user to see first. This
    /// ID is
    /// included in the output URL. When the URL in response is accessed, Amazon
    /// Quick Sight
    /// renders this dashboard if the user has permissions to view it.
    ///
    /// If the user does not have permission to view this dashboard, they see a
    /// permissions
    /// error message.
    initial_dashboard_id: []const u8,

    pub const json_field_names = .{
        .feature_configurations = "FeatureConfigurations",
        .initial_dashboard_id = "InitialDashboardId",
    };
};
