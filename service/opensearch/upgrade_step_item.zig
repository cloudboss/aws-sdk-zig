const UpgradeStep = @import("upgrade_step.zig").UpgradeStep;
const UpgradeStatus = @import("upgrade_status.zig").UpgradeStatus;

/// Represents a single step of an upgrade or upgrade eligibility check
/// workflow.
pub const UpgradeStepItem = struct {
    /// A list of strings containing detailed information about the errors
    /// encountered in a
    /// particular step.
    issues: ?[]const []const u8,

    /// The floating point value representing the progress percentage of a
    /// particular
    /// step.
    progress_percent: ?f64,

    /// One of three steps that an upgrade or upgrade eligibility check goes
    /// through:
    ///
    /// * PreUpgradeCheck
    ///
    /// * Snapshot
    ///
    /// * Upgrade
    upgrade_step: ?UpgradeStep,

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
    upgrade_step_status: ?UpgradeStatus,

    pub const json_field_names = .{
        .issues = "Issues",
        .progress_percent = "ProgressPercent",
        .upgrade_step = "UpgradeStep",
        .upgrade_step_status = "UpgradeStepStatus",
    };
};
