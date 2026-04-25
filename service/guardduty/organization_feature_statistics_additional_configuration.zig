const OrgFeatureAdditionalConfiguration = @import("org_feature_additional_configuration.zig").OrgFeatureAdditionalConfiguration;

/// Information about the coverage statistic for the additional configuration of
/// the feature.
pub const OrganizationFeatureStatisticsAdditionalConfiguration = struct {
    /// Total number of accounts that have enabled the additional configuration.
    enabled_accounts_count: ?i32 = null,

    /// Name of the additional configuration within a feature.
    name: ?OrgFeatureAdditionalConfiguration = null,

    pub const json_field_names = .{
        .enabled_accounts_count = "EnabledAccountsCount",
        .name = "Name",
    };
};
