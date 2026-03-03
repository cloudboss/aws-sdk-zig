const DataSetDateFilterCondition = @import("data_set_date_filter_condition.zig").DataSetDateFilterCondition;
const DataSetNumericFilterCondition = @import("data_set_numeric_filter_condition.zig").DataSetNumericFilterCondition;
const DataSetStringFilterCondition = @import("data_set_string_filter_condition.zig").DataSetStringFilterCondition;

/// A transform operation that filters rows based on a condition.
pub const FilterOperation = struct {
    /// An expression that must evaluate to a Boolean value. Rows for which the
    /// expression
    /// evaluates to true are kept in the dataset.
    condition_expression: ?[]const u8 = null,

    /// A date-based filter condition within a filter operation.
    date_filter_condition: ?DataSetDateFilterCondition = null,

    /// A numeric-based filter condition within a filter operation.
    numeric_filter_condition: ?DataSetNumericFilterCondition = null,

    /// A string-based filter condition within a filter operation.
    string_filter_condition: ?DataSetStringFilterCondition = null,

    pub const json_field_names = .{
        .condition_expression = "ConditionExpression",
        .date_filter_condition = "DateFilterCondition",
        .numeric_filter_condition = "NumericFilterCondition",
        .string_filter_condition = "StringFilterCondition",
    };
};
