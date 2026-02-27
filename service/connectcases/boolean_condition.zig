const BooleanOperands = @import("boolean_operands.zig").BooleanOperands;

/// Boolean condition for a rule. In the Amazon Connect admin website, case
/// rules are known as *case field conditions*. For more information about case
/// field conditions, see [Add case field conditions to a case
/// template](https://docs.aws.amazon.com/connect/latest/adminguide/case-field-conditions.html).
pub const BooleanCondition = union(enum) {
    /// Tests that operandOne is equal to operandTwo.
    equal_to: ?BooleanOperands,
    /// Tests that operandOne is not equal to operandTwo.
    not_equal_to: ?BooleanOperands,

    pub const json_field_names = .{
        .equal_to = "equalTo",
        .not_equal_to = "notEqualTo",
    };
};
