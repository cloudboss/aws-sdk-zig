const OperandOne = @import("operand_one.zig").OperandOne;
const OperandTwo = @import("operand_two.zig").OperandTwo;

/// Boolean operands for a condition. In the Amazon Connect admin website, case
/// rules are known as *case field conditions*. For more information about case
/// field conditions, see [Add case field conditions to a case
/// template](https://docs.aws.amazon.com/connect/latest/adminguide/case-field-conditions.html).
pub const BooleanOperands = struct {
    /// Represents the left hand operand in the condition.
    operand_one: OperandOne,

    /// Represents the right hand operand in the condition.
    operand_two: OperandTwo,

    /// The value of the outer rule if the condition evaluates to true.
    result: bool,

    pub const json_field_names = .{
        .operand_one = "operandOne",
        .operand_two = "operandTwo",
        .result = "result",
    };
};
