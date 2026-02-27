const UsageTopAccountResult = @import("usage_top_account_result.zig").UsageTopAccountResult;
const UsageFeature = @import("usage_feature.zig").UsageFeature;

/// Information about the usage statistics, calculated
/// by top accounts by feature.
pub const UsageTopAccountsResult = struct {
    /// The accounts that contributed to the total usage cost.
    accounts: ?[]const UsageTopAccountResult,

    /// Features by which you can generate the usage statistics.
    ///
    /// `RDS_LOGIN_EVENTS` is currently not supported
    /// with `topAccountsByFeature`.
    feature: ?UsageFeature,

    pub const json_field_names = .{
        .accounts = "Accounts",
        .feature = "Feature",
    };
};
