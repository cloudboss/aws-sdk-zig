const BooleanCondition = @import("boolean_condition.zig").BooleanCondition;

/// A compound condition that combines multiple boolean conditions using logical
/// operators. In the Amazon Connect admin website, case rules are known as
/// *case field conditions*. For more information about case field conditions,
/// see [Add case field conditions to a case
/// template](https://docs.aws.amazon.com/connect/latest/adminguide/case-field-conditions.html).
pub const CompoundCondition = struct {
    /// The list of conditions to combine using the logical operator.
    conditions: []const BooleanCondition,

    pub const json_field_names = .{
        .conditions = "conditions",
    };
};
