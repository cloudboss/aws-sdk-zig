const OrganizationFeatureStatisticsAdditionalConfiguration = @import("organization_feature_statistics_additional_configuration.zig").OrganizationFeatureStatisticsAdditionalConfiguration;
const OrgFeature = @import("org_feature.zig").OrgFeature;

/// Information about the number of accounts
/// that have enabled a specific feature.
pub const OrganizationFeatureStatistics = struct {
    /// Name of the additional configuration.
    additional_configuration: ?[]const OrganizationFeatureStatisticsAdditionalConfiguration,

    /// Total number of accounts that have enabled a specific
    /// feature.
    enabled_accounts_count: ?i32,

    /// Name of the feature.
    name: ?OrgFeature,

    pub const json_field_names = .{
        .additional_configuration = "AdditionalConfiguration",
        .enabled_accounts_count = "EnabledAccountsCount",
        .name = "Name",
    };
};
