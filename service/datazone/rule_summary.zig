const RuleAction = @import("rule_action.zig").RuleAction;
const RuleType = @import("rule_type.zig").RuleType;
const RuleScope = @import("rule_scope.zig").RuleScope;
const RuleTarget = @import("rule_target.zig").RuleTarget;
const RuleTargetType = @import("rule_target_type.zig").RuleTargetType;

/// The summary of the rule.
pub const RuleSummary = struct {
    /// The action of the rule.
    action: ?RuleAction,

    /// The ID of the rule.
    identifier: ?[]const u8,

    /// The timestamp at which the rule was last updated.
    last_updated_by: ?[]const u8,

    /// The name of the rule.
    name: ?[]const u8,

    /// The revision of the rule.
    revision: ?[]const u8,

    /// The type of the rule.
    rule_type: ?RuleType,

    /// The scope of the rule.
    scope: ?RuleScope,

    /// The target of the rule.
    target: ?RuleTarget,

    /// The target type of the rule.
    target_type: ?RuleTargetType,

    /// The timestamp at which the rule was last updated.
    updated_at: ?i64,

    pub const json_field_names = .{
        .action = "action",
        .identifier = "identifier",
        .last_updated_by = "lastUpdatedBy",
        .name = "name",
        .revision = "revision",
        .rule_type = "ruleType",
        .scope = "scope",
        .target = "target",
        .target_type = "targetType",
        .updated_at = "updatedAt",
    };
};
