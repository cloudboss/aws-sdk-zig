const CountAction = @import("count_action.zig").CountAction;
const NoneAction = @import("none_action.zig").NoneAction;

/// The action to use in the place of the action that results from the rule
/// group evaluation. Set the override action to none to leave the result of the
/// rule group alone. Set it to count to override the result to count only.
///
/// You can only use this for rule statements that reference a rule group, like
/// `RuleGroupReferenceStatement` and `ManagedRuleGroupStatement`.
///
/// This option is usually set to none. It does not affect how the rules in the
/// rule group are evaluated. If you want the rules in the rule group to only
/// count
/// matches, do not use this and instead use the rule action override option,
/// with `Count` action, in your rule group reference statement settings.
pub const OverrideAction = struct {
    /// Override the rule group evaluation result to count only.
    ///
    /// This option is usually set to none. It does not affect how the rules in the
    /// rule group are evaluated. If you want the rules in the rule group to only
    /// count
    /// matches, do not use this and instead use the rule action override option,
    /// with `Count` action, in your rule group reference statement settings.
    count: ?CountAction,

    /// Don't override the rule group evaluation result. This is the most common
    /// setting.
    none: ?NoneAction,

    pub const json_field_names = .{
        .count = "Count",
        .none = "None",
    };
};
