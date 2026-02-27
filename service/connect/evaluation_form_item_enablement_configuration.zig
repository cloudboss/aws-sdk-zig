const EvaluationFormItemEnablementAction = @import("evaluation_form_item_enablement_action.zig").EvaluationFormItemEnablementAction;
const EvaluationFormItemEnablementCondition = @import("evaluation_form_item_enablement_condition.zig").EvaluationFormItemEnablementCondition;

/// An item enablement configuration.
pub const EvaluationFormItemEnablementConfiguration = struct {
    /// An enablement action that if condition is satisfied.
    action: EvaluationFormItemEnablementAction,

    /// A condition for item enablement configuration.
    condition: EvaluationFormItemEnablementCondition,

    /// An enablement action that if condition is not satisfied.
    default_action: ?EvaluationFormItemEnablementAction,

    pub const json_field_names = .{
        .action = "Action",
        .condition = "Condition",
        .default_action = "DefaultAction",
    };
};
