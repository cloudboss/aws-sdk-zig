const UpgradeStepItem = @import("upgrade_step_item.zig").UpgradeStepItem;
const UpgradeStatus = @import("upgrade_status.zig").UpgradeStatus;

/// History of the last 10 Upgrades and Upgrade Eligibility Checks.
pub const UpgradeHistory = struct {
    /// UTC Timestamp at which the Upgrade API call was made in
    /// "yyyy-MM-ddTHH:mm:ssZ" format.
    start_timestamp: ?i64,

    /// A list of
    /// `
    /// UpgradeStepItem
    /// `
    /// s representing information about each step performed as pard of a specific
    /// Upgrade or Upgrade Eligibility Check.
    steps_list: ?[]const UpgradeStepItem,

    /// A string that describes the update briefly
    upgrade_name: ?[]const u8,

    /// The overall status of the update. The status can take one of the following
    /// values:
    ///
    /// * In Progress
    ///
    /// * Succeeded
    ///
    /// * Succeeded with Issues
    ///
    /// * Failed
    upgrade_status: ?UpgradeStatus,

    pub const json_field_names = .{
        .start_timestamp = "StartTimestamp",
        .steps_list = "StepsList",
        .upgrade_name = "UpgradeName",
        .upgrade_status = "UpgradeStatus",
    };
};
