const RetentionIntervalUnitValues = @import("retention_interval_unit_values.zig").RetentionIntervalUnitValues;

/// **[Custom snapshot policies only]** Specifies a rule for sharing snapshots
/// across Amazon Web Services accounts.
pub const ShareRule = struct {
    /// The IDs of the Amazon Web Services accounts with which to share the
    /// snapshots.
    target_accounts: []const []const u8,

    /// The period after which snapshots that are shared with other Amazon Web
    /// Services accounts are automatically unshared.
    unshare_interval: ?i32 = null,

    /// The unit of time for the automatic unsharing interval.
    unshare_interval_unit: ?RetentionIntervalUnitValues = null,

    pub const json_field_names = .{
        .target_accounts = "TargetAccounts",
        .unshare_interval = "UnshareInterval",
        .unshare_interval_unit = "UnshareIntervalUnit",
    };
};
