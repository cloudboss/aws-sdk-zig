const EnabledBaselineDriftTypes = @import("enabled_baseline_drift_types.zig").EnabledBaselineDriftTypes;

/// The drift summary of the enabled baseline. Amazon Web Services Control Tower
/// reports inheritance drift when an enabled baseline configuration of a member
/// account is different than the configuration that applies to the OU. Amazon
/// Web Services Control Tower reports this type of drift for a parent or child
/// enabled baseline. One way to repair this drift by resetting the parent
/// enabled baseline, on the OU.
///
/// For example, you may see this type of drift if you move accounts between
/// OUs, but the accounts are not yet (re-)enrolled.
pub const EnabledBaselineDriftStatusSummary = struct {
    /// The types of drift that can be detected for an enabled baseline. Amazon Web
    /// Services Control Tower detects inheritance drift on enabled baselines that
    /// apply at the OU level.
    types: ?EnabledBaselineDriftTypes = null,

    pub const json_field_names = .{
        .types = "types",
    };
};
