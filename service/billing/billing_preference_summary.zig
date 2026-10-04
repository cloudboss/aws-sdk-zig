const BillingPeriod = @import("billing_period.zig").BillingPeriod;
const BillingFeature = @import("billing_feature.zig").BillingFeature;
const PreferenceValue = @import("preference_value.zig").PreferenceValue;

/// A single billing preference entry returned by `GetBillingPreferences`.
pub const BillingPreferenceSummary = struct {
    /// The associated Amazon Web Services account ID. Populated for account-list
    /// keys; `null` otherwise.
    account_id: ?[]const u8 = null,

    /// The display name of the account. Populated together with `accountId`; `null`
    /// otherwise.
    account_name: ?[]const u8 = null,

    /// The billing period associated with the preference change. Populated only for
    /// the history features `RI_SHARING_HISTORY` and `CREDIT_SHARING_HISTORY`.
    billing_period: ?BillingPeriod = null,

    /// The feature this preference belongs to.
    feature: BillingFeature,

    /// The preference key. Format depends on the feature.
    key: []const u8,

    /// The preference value. Valid values: `ENABLED` or `DISABLED`.
    value: PreferenceValue,

    pub const json_field_names = .{
        .account_id = "accountId",
        .account_name = "accountName",
        .billing_period = "billingPeriod",
        .feature = "feature",
        .key = "key",
        .value = "value",
    };
};
