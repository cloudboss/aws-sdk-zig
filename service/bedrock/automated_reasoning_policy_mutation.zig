const AutomatedReasoningPolicyAddRuleMutation = @import("automated_reasoning_policy_add_rule_mutation.zig").AutomatedReasoningPolicyAddRuleMutation;
const AutomatedReasoningPolicyAddTypeMutation = @import("automated_reasoning_policy_add_type_mutation.zig").AutomatedReasoningPolicyAddTypeMutation;
const AutomatedReasoningPolicyAddVariableMutation = @import("automated_reasoning_policy_add_variable_mutation.zig").AutomatedReasoningPolicyAddVariableMutation;
const AutomatedReasoningPolicyDeleteRuleMutation = @import("automated_reasoning_policy_delete_rule_mutation.zig").AutomatedReasoningPolicyDeleteRuleMutation;
const AutomatedReasoningPolicyDeleteTypeMutation = @import("automated_reasoning_policy_delete_type_mutation.zig").AutomatedReasoningPolicyDeleteTypeMutation;
const AutomatedReasoningPolicyDeleteVariableMutation = @import("automated_reasoning_policy_delete_variable_mutation.zig").AutomatedReasoningPolicyDeleteVariableMutation;
const AutomatedReasoningPolicyUpdateRuleMutation = @import("automated_reasoning_policy_update_rule_mutation.zig").AutomatedReasoningPolicyUpdateRuleMutation;
const AutomatedReasoningPolicyUpdateTypeMutation = @import("automated_reasoning_policy_update_type_mutation.zig").AutomatedReasoningPolicyUpdateTypeMutation;
const AutomatedReasoningPolicyUpdateVariableMutation = @import("automated_reasoning_policy_update_variable_mutation.zig").AutomatedReasoningPolicyUpdateVariableMutation;

/// A container for various mutation operations that can be applied to an
/// Automated Reasoning policy, including adding, updating, and deleting policy
/// elements.
pub const AutomatedReasoningPolicyMutation = union(enum) {
    /// A mutation to add a new rule to the policy.
    add_rule: ?AutomatedReasoningPolicyAddRuleMutation,
    /// A mutation to add a new custom type to the policy.
    add_type: ?AutomatedReasoningPolicyAddTypeMutation,
    /// A mutation to add a new variable to the policy.
    add_variable: ?AutomatedReasoningPolicyAddVariableMutation,
    /// A mutation to remove a rule from the policy.
    delete_rule: ?AutomatedReasoningPolicyDeleteRuleMutation,
    /// A mutation to remove a custom type from the policy.
    delete_type: ?AutomatedReasoningPolicyDeleteTypeMutation,
    /// A mutation to remove a variable from the policy.
    delete_variable: ?AutomatedReasoningPolicyDeleteVariableMutation,
    /// A mutation to modify an existing rule in the policy.
    update_rule: ?AutomatedReasoningPolicyUpdateRuleMutation,
    /// A mutation to modify an existing custom type in the policy.
    update_type: ?AutomatedReasoningPolicyUpdateTypeMutation,
    /// A mutation to modify an existing variable in the policy.
    update_variable: ?AutomatedReasoningPolicyUpdateVariableMutation,

    pub const json_field_names = .{
        .add_rule = "addRule",
        .add_type = "addType",
        .add_variable = "addVariable",
        .delete_rule = "deleteRule",
        .delete_type = "deleteType",
        .delete_variable = "deleteVariable",
        .update_rule = "updateRule",
        .update_type = "updateType",
        .update_variable = "updateVariable",
    };
};
