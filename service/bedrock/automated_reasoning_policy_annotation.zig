const AutomatedReasoningPolicyAddRuleAnnotation = @import("automated_reasoning_policy_add_rule_annotation.zig").AutomatedReasoningPolicyAddRuleAnnotation;
const AutomatedReasoningPolicyAddRuleFromNaturalLanguageAnnotation = @import("automated_reasoning_policy_add_rule_from_natural_language_annotation.zig").AutomatedReasoningPolicyAddRuleFromNaturalLanguageAnnotation;
const AutomatedReasoningPolicyAddTypeAnnotation = @import("automated_reasoning_policy_add_type_annotation.zig").AutomatedReasoningPolicyAddTypeAnnotation;
const AutomatedReasoningPolicyAddVariableAnnotation = @import("automated_reasoning_policy_add_variable_annotation.zig").AutomatedReasoningPolicyAddVariableAnnotation;
const AutomatedReasoningPolicyDeleteRuleAnnotation = @import("automated_reasoning_policy_delete_rule_annotation.zig").AutomatedReasoningPolicyDeleteRuleAnnotation;
const AutomatedReasoningPolicyDeleteTypeAnnotation = @import("automated_reasoning_policy_delete_type_annotation.zig").AutomatedReasoningPolicyDeleteTypeAnnotation;
const AutomatedReasoningPolicyDeleteVariableAnnotation = @import("automated_reasoning_policy_delete_variable_annotation.zig").AutomatedReasoningPolicyDeleteVariableAnnotation;
const AutomatedReasoningPolicyIngestContentAnnotation = @import("automated_reasoning_policy_ingest_content_annotation.zig").AutomatedReasoningPolicyIngestContentAnnotation;
const AutomatedReasoningPolicyUpdateFromRuleFeedbackAnnotation = @import("automated_reasoning_policy_update_from_rule_feedback_annotation.zig").AutomatedReasoningPolicyUpdateFromRuleFeedbackAnnotation;
const AutomatedReasoningPolicyUpdateFromScenarioFeedbackAnnotation = @import("automated_reasoning_policy_update_from_scenario_feedback_annotation.zig").AutomatedReasoningPolicyUpdateFromScenarioFeedbackAnnotation;
const AutomatedReasoningPolicyUpdateRuleAnnotation = @import("automated_reasoning_policy_update_rule_annotation.zig").AutomatedReasoningPolicyUpdateRuleAnnotation;
const AutomatedReasoningPolicyUpdateTypeAnnotation = @import("automated_reasoning_policy_update_type_annotation.zig").AutomatedReasoningPolicyUpdateTypeAnnotation;
const AutomatedReasoningPolicyUpdateVariableAnnotation = @import("automated_reasoning_policy_update_variable_annotation.zig").AutomatedReasoningPolicyUpdateVariableAnnotation;

/// Contains the various operations that can be performed on an Automated
/// Reasoning policy, including adding, updating, and deleting rules, variables,
/// and types.
pub const AutomatedReasoningPolicyAnnotation = union(enum) {
    /// An operation to add a new logical rule to the policy using formal
    /// mathematical expressions.
    add_rule: ?AutomatedReasoningPolicyAddRuleAnnotation,
    /// An operation to add a new rule by converting natural language descriptions
    /// into formal logical expressions.
    add_rule_from_natural_language: ?AutomatedReasoningPolicyAddRuleFromNaturalLanguageAnnotation,
    /// An operation to add a new custom type to the policy, defining a set of
    /// possible values for policy variables.
    add_type: ?AutomatedReasoningPolicyAddTypeAnnotation,
    /// An operation to add a new variable to the policy, which can be used in rule
    /// expressions to represent dynamic values.
    add_variable: ?AutomatedReasoningPolicyAddVariableAnnotation,
    /// An operation to remove a rule from the policy.
    delete_rule: ?AutomatedReasoningPolicyDeleteRuleAnnotation,
    /// An operation to remove a custom type from the policy. The type must not be
    /// referenced by any variables or rules.
    delete_type: ?AutomatedReasoningPolicyDeleteTypeAnnotation,
    /// An operation to remove a variable from the policy. The variable must not be
    /// referenced by any rules.
    delete_variable: ?AutomatedReasoningPolicyDeleteVariableAnnotation,
    /// An operation to process and incorporate new content into the policy,
    /// extracting additional rules and concepts.
    ingest_content: ?AutomatedReasoningPolicyIngestContentAnnotation,
    /// An operation to update the policy based on feedback about how specific rules
    /// performed during testing or validation.
    update_from_rules_feedback: ?AutomatedReasoningPolicyUpdateFromRuleFeedbackAnnotation,
    /// An operation to update the policy based on feedback about how it performed
    /// on specific test scenarios.
    update_from_scenario_feedback: ?AutomatedReasoningPolicyUpdateFromScenarioFeedbackAnnotation,
    /// An operation to modify an existing rule in the policy, such as changing its
    /// logical expression or conditions.
    update_rule: ?AutomatedReasoningPolicyUpdateRuleAnnotation,
    /// An operation to modify an existing custom type in the policy, such as
    /// changing its name, description, or allowed values.
    update_type: ?AutomatedReasoningPolicyUpdateTypeAnnotation,
    /// An operation to modify an existing variable in the policy, such as changing
    /// its name, type, or description.
    update_variable: ?AutomatedReasoningPolicyUpdateVariableAnnotation,

    pub const json_field_names = .{
        .add_rule = "addRule",
        .add_rule_from_natural_language = "addRuleFromNaturalLanguage",
        .add_type = "addType",
        .add_variable = "addVariable",
        .delete_rule = "deleteRule",
        .delete_type = "deleteType",
        .delete_variable = "deleteVariable",
        .ingest_content = "ingestContent",
        .update_from_rules_feedback = "updateFromRulesFeedback",
        .update_from_scenario_feedback = "updateFromScenarioFeedback",
        .update_rule = "updateRule",
        .update_type = "updateType",
        .update_variable = "updateVariable",
    };
};
