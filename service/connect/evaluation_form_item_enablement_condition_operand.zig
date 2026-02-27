const EvaluationFormItemEnablementCondition = @import("evaluation_form_item_enablement_condition.zig").EvaluationFormItemEnablementCondition;
const EvaluationFormItemEnablementExpression = @import("evaluation_form_item_enablement_expression.zig").EvaluationFormItemEnablementExpression;

/// An operand of the enablement condition.
pub const EvaluationFormItemEnablementConditionOperand = union(enum) {
    /// A condition for item enablement.
    condition: ?EvaluationFormItemEnablementCondition,
    /// An expression of the enablement condition.
    expression: ?EvaluationFormItemEnablementExpression,

    pub const json_field_names = .{
        .condition = "Condition",
        .expression = "Expression",
    };
};
