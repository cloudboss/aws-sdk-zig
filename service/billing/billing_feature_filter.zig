const BillingFeatureFilterName = @import("billing_feature_filter_name.zig").BillingFeatureFilterName;

/// A filter that narrows the set of preferences returned by
/// `GetBillingPreferences`.
pub const BillingFeatureFilter = struct {
    /// The filter name. Currently the only supported value is `PREFERENCE_KEY`.
    name: ?BillingFeatureFilterName = null,

    /// The filter values to match. For `PREFERENCE_KEY`, supply 1 to 10 preference
    /// key values to match.
    value: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
