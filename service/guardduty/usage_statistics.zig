const UsageAccountResult = @import("usage_account_result.zig").UsageAccountResult;
const UsageDataSourceResult = @import("usage_data_source_result.zig").UsageDataSourceResult;
const UsageFeatureResult = @import("usage_feature_result.zig").UsageFeatureResult;
const UsageResourceResult = @import("usage_resource_result.zig").UsageResourceResult;
const UsageTopAccountsResult = @import("usage_top_accounts_result.zig").UsageTopAccountsResult;

/// Contains the result of GuardDuty usage. If a UsageStatisticType is provided
/// the result for
/// other types will be null.
pub const UsageStatistics = struct {
    /// The usage statistic sum organized by account ID.
    sum_by_account: ?[]const UsageAccountResult = null,

    /// The usage statistic sum organized by on data source.
    sum_by_data_source: ?[]const UsageDataSourceResult = null,

    /// The usage statistic sum organized by feature.
    sum_by_feature: ?[]const UsageFeatureResult = null,

    /// The usage statistic sum organized by resource.
    sum_by_resource: ?[]const UsageResourceResult = null,

    /// Lists the top 50 accounts by feature that have generated the most
    /// GuardDuty usage, in the order from most to least expensive.
    ///
    /// Currently, this doesn't support `RDS_LOGIN_EVENTS`.
    top_accounts_by_feature: ?[]const UsageTopAccountsResult = null,

    /// Lists the top 50 resources that have generated the most GuardDuty usage, in
    /// order from
    /// most to least expensive.
    top_resources: ?[]const UsageResourceResult = null,

    pub const json_field_names = .{
        .sum_by_account = "SumByAccount",
        .sum_by_data_source = "SumByDataSource",
        .sum_by_feature = "SumByFeature",
        .sum_by_resource = "SumByResource",
        .top_accounts_by_feature = "TopAccountsByFeature",
        .top_resources = "TopResources",
    };
};
