const RuleCondition = @import("rule_condition.zig").RuleCondition;

/// The properties of a rule condition that provides the ability to use more
/// complex syntax.
pub const RuleConditionProperties = struct {
    /// A list of rule objects, each of which have fields `ruleName` and
    /// `condition`.
    rules: []const RuleCondition,

    pub const json_field_names = .{
        .rules = "rules",
    };
};
