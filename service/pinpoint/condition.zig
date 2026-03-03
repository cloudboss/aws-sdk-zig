const SimpleCondition = @import("simple_condition.zig").SimpleCondition;
const Operator = @import("operator.zig").Operator;

/// Specifies the conditions to evaluate for an activity in a journey, and how
/// to evaluate those conditions.
pub const Condition = struct {
    /// The conditions to evaluate for the activity.
    conditions: ?[]const SimpleCondition = null,

    /// Specifies how to handle multiple conditions for the activity. For example,
    /// if you specify two conditions for an activity, whether both or only one of
    /// the conditions must be met for the activity to be performed.
    operator: ?Operator = null,

    pub const json_field_names = .{
        .conditions = "Conditions",
        .operator = "Operator",
    };
};
