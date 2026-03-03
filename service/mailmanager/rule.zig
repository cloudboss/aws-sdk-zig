const RuleAction = @import("rule_action.zig").RuleAction;
const RuleCondition = @import("rule_condition.zig").RuleCondition;

/// A rule contains conditions, "unless conditions" and actions. For each
/// envelope recipient of an email, if all conditions match and none of the
/// "unless conditions" match, then all of the actions are executed
/// sequentially. If no conditions are provided, the rule always applies and the
/// actions are implicitly executed. If only "unless conditions" are provided,
/// the rule applies if the email does not match the evaluation of the "unless
/// conditions".
pub const Rule = struct {
    /// The list of actions to execute when the conditions match the incoming email,
    /// and none of the "unless conditions" match.
    actions: []const RuleAction,

    /// The conditions of this rule. All conditions must match the email for the
    /// actions to be executed. An empty list of conditions means that all emails
    /// match, but are still subject to any "unless conditions"
    conditions: ?[]const RuleCondition = null,

    /// The user-friendly name of the rule.
    name: ?[]const u8 = null,

    /// The "unless conditions" of this rule. None of the conditions can match the
    /// email for the actions to be executed. If any of these conditions do match
    /// the email, then the actions are not executed.
    unless: ?[]const RuleCondition = null,

    pub const json_field_names = .{
        .actions = "Actions",
        .conditions = "Conditions",
        .name = "Name",
        .unless = "Unless",
    };
};
