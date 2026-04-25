const OrganizationFeatureStatistics = @import("organization_feature_statistics.zig").OrganizationFeatureStatistics;

/// Information about the coverage statistics of the features for the entire
/// Amazon Web Services organization.
///
/// When you create a new Amazon Web Services organization, it might take up to
/// 24 hours to generate the statistics summary for this organization.
pub const OrganizationStatistics = struct {
    /// Total number of active accounts in your Amazon Web Services organization
    /// that are associated with GuardDuty.
    active_accounts_count: ?i32 = null,

    /// Retrieves the coverage statistics for each feature.
    count_by_feature: ?[]const OrganizationFeatureStatistics = null,

    /// Total number of accounts that have enabled GuardDuty.
    enabled_accounts_count: ?i32 = null,

    /// Total number of accounts in your Amazon Web Services organization that are
    /// associated with GuardDuty.
    member_accounts_count: ?i32 = null,

    /// Total number of accounts in your Amazon Web Services organization.
    total_accounts_count: ?i32 = null,

    pub const json_field_names = .{
        .active_accounts_count = "ActiveAccountsCount",
        .count_by_feature = "CountByFeature",
        .enabled_accounts_count = "EnabledAccountsCount",
        .member_accounts_count = "MemberAccountsCount",
        .total_accounts_count = "TotalAccountsCount",
    };
};
