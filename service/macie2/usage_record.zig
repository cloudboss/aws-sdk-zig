const UsageByAccount = @import("usage_by_account.zig").UsageByAccount;

/// Provides quota and aggregated usage data for an Amazon Macie account.
pub const UsageRecord = struct {
    /// The unique identifier for the Amazon Web Services account that the data
    /// applies to.
    account_id: ?[]const u8,

    /// The date and time, in UTC and extended ISO 8601 format, when the free trial
    /// of automated sensitive data discovery started for the account. This value is
    /// null if automated sensitive data discovery hasn't been enabled for the
    /// account.
    automated_discovery_free_trial_start_date: ?i64,

    /// The date and time, in UTC and extended ISO 8601 format, when the Amazon
    /// Macie free trial started for the account.
    free_trial_start_date: ?i64,

    /// An array of objects that contains usage data and quotas for the account.
    /// Each object contains the data for a specific usage metric and the
    /// corresponding quota.
    usage: ?[]const UsageByAccount,

    pub const json_field_names = .{
        .account_id = "accountId",
        .automated_discovery_free_trial_start_date = "automatedDiscoveryFreeTrialStartDate",
        .free_trial_start_date = "freeTrialStartDate",
        .usage = "usage",
    };
};
