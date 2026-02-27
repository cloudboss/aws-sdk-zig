const CommandParameterValueComparisonOperator = @import("command_parameter_value_comparison_operator.zig").CommandParameterValueComparisonOperator;
const CommandParameterValueComparisonOperand = @import("command_parameter_value_comparison_operand.zig").CommandParameterValueComparisonOperand;

/// A condition for the command parameter that must be evaluated to true for
/// successful creation of a command execution.
pub const CommandParameterValueCondition = struct {
    /// The comparison operator for the command parameter.
    ///
    /// IN_RANGE, and NOT_IN_RANGE operators include boundary values.
    comparison_operator: CommandParameterValueComparisonOperator,

    /// The comparison operand for the command parameter.
    operand: CommandParameterValueComparisonOperand,

    pub const json_field_names = .{
        .comparison_operator = "comparisonOperator",
        .operand = "operand",
    };
};
