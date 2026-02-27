const UpgradeStep = @import("upgrade_step.zig").UpgradeStep;
const UpgradeStatus = @import("upgrade_status.zig").UpgradeStatus;

/// Represents a single step of the Upgrade or Upgrade Eligibility Check
/// workflow.
pub const UpgradeStepItem = struct {
    /// A list of strings containing detailed information about the errors
    /// encountered in a particular step.
    issues: ?[]const []const u8,

    /// The Floating point value representing progress percentage of a particular
    /// step.
    progress_percent: ?f64,

    /// Represents one of 3 steps that an Upgrade or Upgrade Eligibility Check does
    /// through:
    ///
    /// * PreUpgradeCheck
    ///
    /// * Snapshot
    ///
    /// * Upgrade
    upgrade_step: ?UpgradeStep,

    /// The status of a particular step during an upgrade. The status can take one
    /// of the following values:
    ///
    /// * In Progress
    ///
    /// * Succeeded
    ///
    /// * Succeeded with Issues
    ///
    /// * Failed
    upgrade_step_status: ?UpgradeStatus,

    pub const json_field_names = .{
        .issues = "Issues",
        .progress_percent = "ProgressPercent",
        .upgrade_step = "UpgradeStep",
        .upgrade_step_status = "UpgradeStepStatus",
    };
};
