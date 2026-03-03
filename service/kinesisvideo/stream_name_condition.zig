const ComparisonOperator = @import("comparison_operator.zig").ComparisonOperator;

/// Specifies the condition that streams must satisfy to be returned when you
/// list
/// streams (see the `ListStreams` API). A condition has a comparison operation
/// and a value. Currently, you can specify only the `BEGINS_WITH` operator,
/// which finds streams whose names start with a given prefix.
pub const StreamNameCondition = struct {
    /// A comparison operator. Currently, you can specify only the `BEGINS_WITH`
    /// operator, which finds streams whose names start with a given prefix.
    comparison_operator: ?ComparisonOperator = null,

    /// A value to compare.
    comparison_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .comparison_operator = "ComparisonOperator",
        .comparison_value = "ComparisonValue",
    };
};
