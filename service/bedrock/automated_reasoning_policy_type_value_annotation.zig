const AutomatedReasoningPolicyAddTypeValue = @import("automated_reasoning_policy_add_type_value.zig").AutomatedReasoningPolicyAddTypeValue;
const AutomatedReasoningPolicyDeleteTypeValue = @import("automated_reasoning_policy_delete_type_value.zig").AutomatedReasoningPolicyDeleteTypeValue;
const AutomatedReasoningPolicyUpdateTypeValue = @import("automated_reasoning_policy_update_type_value.zig").AutomatedReasoningPolicyUpdateTypeValue;

/// An annotation for managing values within custom types, including adding,
/// updating, or removing specific type values.
pub const AutomatedReasoningPolicyTypeValueAnnotation = union(enum) {
    /// An operation to add a new value to an existing custom type.
    add_type_value: ?AutomatedReasoningPolicyAddTypeValue,
    /// An operation to remove a value from an existing custom type.
    delete_type_value: ?AutomatedReasoningPolicyDeleteTypeValue,
    /// An operation to modify an existing value within a custom type.
    update_type_value: ?AutomatedReasoningPolicyUpdateTypeValue,

    pub const json_field_names = .{
        .add_type_value = "addTypeValue",
        .delete_type_value = "deleteTypeValue",
        .update_type_value = "updateTypeValue",
    };
};
