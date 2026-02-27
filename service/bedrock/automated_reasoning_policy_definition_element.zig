const AutomatedReasoningPolicyDefinitionRule = @import("automated_reasoning_policy_definition_rule.zig").AutomatedReasoningPolicyDefinitionRule;
const AutomatedReasoningPolicyDefinitionType = @import("automated_reasoning_policy_definition_type.zig").AutomatedReasoningPolicyDefinitionType;
const AutomatedReasoningPolicyDefinitionVariable = @import("automated_reasoning_policy_definition_variable.zig").AutomatedReasoningPolicyDefinitionVariable;

/// Represents a single element in an Automated Reasoning policy definition,
/// such as a rule, variable, or type definition.
pub const AutomatedReasoningPolicyDefinitionElement = union(enum) {
    /// A rule element within the policy definition that contains a formal logical
    /// expression used for validation.
    policy_definition_rule: ?AutomatedReasoningPolicyDefinitionRule,
    /// A custom type element within the policy definition that defines a set of
    /// possible values for variables.
    policy_definition_type: ?AutomatedReasoningPolicyDefinitionType,
    /// A variable element within the policy definition that represents a concept
    /// used in logical expressions and rules.
    policy_definition_variable: ?AutomatedReasoningPolicyDefinitionVariable,

    pub const json_field_names = .{
        .policy_definition_rule = "policyDefinitionRule",
        .policy_definition_type = "policyDefinitionType",
        .policy_definition_variable = "policyDefinitionVariable",
    };
};
