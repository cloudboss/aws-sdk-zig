const LongConditionOperator = @import("long_condition_operator.zig").LongConditionOperator;

/// The long condition contains a `Value` and can optionally contain an
/// `Operator`.
pub const LongCondition = struct {
    /// A string that defines what values will be returned.
    ///
    /// If this is included, avoid combinations of operators that will return all
    /// possible values. For example, including both `EQUALS_TO` and `NOT_EQUALS_TO`
    /// with a value of `4` will return all values.
    operator: LongConditionOperator = .equals_to,

    /// The value of an item included in one of the search item filters.
    value: i64,

    pub const json_field_names = .{
        .operator = "Operator",
        .value = "Value",
    };
};
