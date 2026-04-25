const CompoundCondition = @import("compound_condition.zig").CompoundCondition;
const BooleanOperands = @import("boolean_operands.zig").BooleanOperands;

/// Boolean condition for a rule. In the Amazon Connect admin website, case
/// rules are known as *case field conditions*. For more information about case
/// field conditions, see [Add case field conditions to a case
/// template](https://docs.aws.amazon.com/connect/latest/adminguide/case-field-conditions.html).
pub const BooleanCondition = union(enum) {
    /// Combines multiple conditions with AND operator. All conditions must be true
    /// for the compound condition to be true.
    and_all: ?CompoundCondition,
    /// Tests that operandOne is equal to operandTwo.
    equal_to: ?BooleanOperands,
    /// Tests that operandOne is not equal to operandTwo.
    not_equal_to: ?BooleanOperands,
    /// Combines multiple conditions with OR operator. At least one condition must
    /// be true for the compound condition to be true.
    or_all: ?CompoundCondition,

    pub const json_field_names = .{
        .and_all = "andAll",
        .equal_to = "equalTo",
        .not_equal_to = "notEqualTo",
        .or_all = "orAll",
    };
};
