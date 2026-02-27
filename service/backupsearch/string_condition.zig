const StringConditionOperator = @import("string_condition_operator.zig").StringConditionOperator;

/// This contains the value of the string and can contain one or more operators.
pub const StringCondition = struct {
    /// A string that defines what values will be returned.
    ///
    /// If this is included, avoid combinations of operators that will return all
    /// possible values. For example, including both `EQUALS_TO` and `NOT_EQUALS_TO`
    /// with a value of `4` will return all values.
    operator: StringConditionOperator = "EQUALS_TO",

    /// The value of the string.
    value: []const u8,

    pub const json_field_names = .{
        .operator = "Operator",
        .value = "Value",
    };
};
