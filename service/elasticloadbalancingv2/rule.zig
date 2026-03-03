const Action = @import("action.zig").Action;
const RuleCondition = @import("rule_condition.zig").RuleCondition;
const RuleTransform = @import("rule_transform.zig").RuleTransform;

/// Information about a rule.
pub const Rule = struct {
    /// The actions. Each rule must include exactly one of the following types of
    /// actions:
    /// `forward`, `redirect`, or `fixed-response`, and it must be
    /// the last action to be performed.
    actions: ?[]const Action = null,

    /// The conditions. Each rule can include zero or one of the following
    /// conditions:
    /// `http-request-method`, `host-header`, `path-pattern`, and
    /// `source-ip`, and zero or more of the following conditions:
    /// `http-header` and `query-string`.
    conditions: ?[]const RuleCondition = null,

    /// Indicates whether this is the default rule.
    is_default: ?bool = null,

    /// The priority.
    priority: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the rule.
    rule_arn: ?[]const u8 = null,

    /// The transforms for the rule.
    transforms: ?[]const RuleTransform = null,
};
