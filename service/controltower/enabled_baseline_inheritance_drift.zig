const EnabledBaselineDriftStatus = @import("enabled_baseline_drift_status.zig").EnabledBaselineDriftStatus;

/// The inheritance drift summary for the enabled baseline. Inheritance drift
/// occurs when any accounts in the target OU do not match the baseline
/// configuration defined on that OU.
pub const EnabledBaselineInheritanceDrift = struct {
    /// The inheritance drift status for enabled baselines.
    status: ?EnabledBaselineDriftStatus,

    pub const json_field_names = .{
        .status = "status",
    };
};
