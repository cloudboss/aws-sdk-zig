const RuleAction = @import("rule_action.zig").RuleAction;

/// Action setting to use in the place of a rule action that is configured
/// inside the rule group. You specify one override for each rule whose action
/// you want to change.
///
/// Verify the rule names in your overrides carefully. With managed rule groups,
/// WAF silently ignores any override that uses an invalid rule name. With
/// customer-owned rule groups, invalid rule names in your overrides will cause
/// web ACL updates to fail. An invalid rule name is any name that doesn't
/// exactly match the case-sensitive name of an existing rule in the rule group.
///
/// You can use overrides for testing, for example you can override all of rule
/// actions to `Count` and then monitor the resulting count metrics to
/// understand how the rule group would handle your web traffic. You can also
/// permanently override some or all actions, to modify how the rule group
/// manages your web traffic.
pub const RuleActionOverride = struct {
    /// The override action to use, in place of the configured action of the rule in
    /// the rule group.
    action_to_use: RuleAction,

    /// The name of the rule to override.
    ///
    /// Verify the rule names in your overrides carefully. With managed rule groups,
    /// WAF silently ignores any override that uses an invalid rule name. With
    /// customer-owned rule groups, invalid rule names in your overrides will cause
    /// web ACL updates to fail. An invalid rule name is any name that doesn't
    /// exactly match the case-sensitive name of an existing rule in the rule group.
    name: []const u8,

    pub const json_field_names = .{
        .action_to_use = "ActionToUse",
        .name = "Name",
    };
};
