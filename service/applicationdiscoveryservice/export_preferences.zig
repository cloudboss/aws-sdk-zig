const Ec2RecommendationsExportPreferences = @import("ec_2_recommendations_export_preferences.zig").Ec2RecommendationsExportPreferences;

/// Indicates the type of data that is being exported. Only one
/// `ExportPreferences` can be enabled for a
/// [StartExportTask](https://docs.aws.amazon.com/application-discovery/latest/APIReference/API_StartExportTask.html) action.
pub const ExportPreferences = union(enum) {
    /// If enabled, exported data includes EC2 instance type matches for on-premises
    /// servers
    /// discovered through Amazon Web Services Application Discovery Service.
    ec_2_recommendations_preferences: ?Ec2RecommendationsExportPreferences,

    pub const json_field_names = .{
        .ec_2_recommendations_preferences = "ec2RecommendationsPreferences",
    };
};
