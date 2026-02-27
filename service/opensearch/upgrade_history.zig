const UpgradeStepItem = @import("upgrade_step_item.zig").UpgradeStepItem;
const UpgradeStatus = @import("upgrade_status.zig").UpgradeStatus;

/// History of the last 10 upgrades and upgrade eligibility checks for an Amazon
/// OpenSearch Service domain.
pub const UpgradeHistory = struct {
    /// UTC timestamp at which the upgrade API call was made, in the format
    /// `yyyy-MM-ddTHH:mm:ssZ`.
    start_timestamp: ?i64,

    /// A list of each step performed as part of a specific upgrade or upgrade
    /// eligibility
    /// check.
    steps_list: ?[]const UpgradeStepItem,

    /// A string that describes the upgrade.
    upgrade_name: ?[]const u8,

    /// The current status of the upgrade. The status can take one of the following
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
