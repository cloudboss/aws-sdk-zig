const PreferenceValue = @import("preference_value.zig").PreferenceValue;

/// A single key/value entry used to update a billing preference.
pub const BillingPreferenceForKey = struct {
    /// The preference key. Format depends on the feature being updated.
    key: []const u8,

    /// The preference value. Valid values: `ENABLED` or `DISABLED`.
    value: PreferenceValue,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
