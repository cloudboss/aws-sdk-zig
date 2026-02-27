const OverrideAction = @import("override_action.zig").OverrideAction;

/// The setting that allows the policy owner to change the behavior of the rule
/// group within a policy.
pub const StatefulRuleGroupOverride = struct {
    /// The action that changes the rule group from `DROP` to `ALERT`. This only
    /// applies to
    /// managed rule groups.
    action: ?OverrideAction,

    pub const json_field_names = .{
        .action = "Action",
    };
};
