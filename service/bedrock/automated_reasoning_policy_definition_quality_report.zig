const AutomatedReasoningPolicyDisjointRuleSet = @import("automated_reasoning_policy_disjoint_rule_set.zig").AutomatedReasoningPolicyDisjointRuleSet;
const AutomatedReasoningPolicyDefinitionTypeValuePair = @import("automated_reasoning_policy_definition_type_value_pair.zig").AutomatedReasoningPolicyDefinitionTypeValuePair;

/// Provides a comprehensive analysis of the quality and completeness of an
/// Automated Reasoning policy definition, highlighting potential issues and
/// optimization opportunities.
pub const AutomatedReasoningPolicyDefinitionQualityReport = struct {
    /// A list of rules that may conflict with each other, potentially leading to
    /// inconsistent policy behavior.
    conflicting_rules: []const []const u8,

    /// Groups of rules that operate on completely separate sets of variables,
    /// indicating the policy may be addressing multiple unrelated concerns.
    disjoint_rule_sets: []const AutomatedReasoningPolicyDisjointRuleSet,

    /// The total number of rules defined in the policy.
    rule_count: i32,

    /// The total number of custom types defined in the policy.
    type_count: i32,

    /// A list of custom types that are defined but not referenced by any variables
    /// or rules, suggesting they may be unnecessary.
    unused_types: []const []const u8,

    /// A list of type values that are defined but never used in any rules,
    /// indicating potential cleanup opportunities.
    unused_type_values: []const AutomatedReasoningPolicyDefinitionTypeValuePair,

    /// A list of variables that are defined but not referenced by any rules,
    /// suggesting they may be unnecessary.
    unused_variables: []const []const u8,

    /// The total number of variables defined in the policy.
    variable_count: i32,

    pub const json_field_names = .{
        .conflicting_rules = "conflictingRules",
        .disjoint_rule_sets = "disjointRuleSets",
        .rule_count = "ruleCount",
        .type_count = "typeCount",
        .unused_types = "unusedTypes",
        .unused_type_values = "unusedTypeValues",
        .unused_variables = "unusedVariables",
        .variable_count = "variableCount",
    };
};
