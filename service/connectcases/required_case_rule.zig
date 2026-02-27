const BooleanCondition = @import("boolean_condition.zig").BooleanCondition;

/// Required rule type, used to indicate whether a field is required. In the
/// Amazon Connect admin website, case rules are known as *case field
/// conditions*. For more information about case field conditions, see [Add case
/// field conditions to a case
/// template](https://docs.aws.amazon.com/connect/latest/adminguide/case-field-conditions.html).
pub const RequiredCaseRule = struct {
    /// List of conditions for the required rule; the first condition to evaluate to
    /// true dictates the value of the rule.
    conditions: []const BooleanCondition,

    /// The value of the rule (that is, whether the field is required) should none
    /// of the conditions evaluate to true.
    default_value: bool,

    pub const json_field_names = .{
        .conditions = "conditions",
        .default_value = "defaultValue",
    };
};
