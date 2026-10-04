const ConditionalValidation = @import("conditional_validation.zig").ConditionalValidation;
const FieldCondition = @import("field_condition.zig").FieldCondition;

/// A single conditional rule that resolves to a field behavior when all of its
/// conditions evaluate to true. Conditions within a rule are combined with
/// logical AND: all conditions must match for the rule to fire.
pub const ConditionalRule = struct {
    /// Optional per-rule validation constraints (minimum length, maximum length,
    /// regex pattern, allowed select values) that override the field's default
    /// validation when this rule matches.
    conditional_validation: ?ConditionalValidation = null,

    /// The conditions that must all evaluate to true for this rule to match.
    /// Conditions are combined with logical AND. Use multiple rules with the same
    /// **RuleBehavior** to express logical OR.
    conditions: []const FieldCondition,

    /// The field behavior that applies when all conditions in this rule match.
    /// Valid values are **REQUIRED**, **OPTIONAL**, and **DISALLOWED**.
    rule_behavior: []const u8,

    pub const json_field_names = .{
        .conditional_validation = "ConditionalValidation",
        .conditions = "Conditions",
        .rule_behavior = "RuleBehavior",
    };
};
