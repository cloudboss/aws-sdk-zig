const TimeConditionOperator = @import("time_condition_operator.zig").TimeConditionOperator;

/// A time condition denotes a creation time, last modification time, or other
/// time.
pub const TimeCondition = struct {
    /// A string that defines what values will be returned.
    ///
    /// If this is included, avoid combinations of operators that will return all
    /// possible values. For example, including both `EQUALS_TO` and `NOT_EQUALS_TO`
    /// with a value of `4` will return all values.
    operator: TimeConditionOperator = .equals_to,

    /// This is the timestamp value of the time condition.
    value: i64,

    pub const json_field_names = .{
        .operator = "Operator",
        .value = "Value",
    };
};
