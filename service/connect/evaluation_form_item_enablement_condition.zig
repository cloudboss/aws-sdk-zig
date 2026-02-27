const EvaluationFormItemEnablementConditionOperand = @import("evaluation_form_item_enablement_condition_operand.zig").EvaluationFormItemEnablementConditionOperand;
const EvaluationFormItemEnablementOperator = @import("evaluation_form_item_enablement_operator.zig").EvaluationFormItemEnablementOperator;

/// A condition for item enablement.
pub const EvaluationFormItemEnablementCondition = struct {
    /// Operands of the enablement condition.
    operands: []const EvaluationFormItemEnablementConditionOperand,

    /// The operator to be used to be applied to operands if more than one provided.
    operator: ?EvaluationFormItemEnablementOperator,

    pub const json_field_names = .{
        .operands = "Operands",
        .operator = "Operator",
    };
};
