const DataSetNumericComparisonFilterOperator = @import("data_set_numeric_comparison_filter_operator.zig").DataSetNumericComparisonFilterOperator;
const DataSetNumericFilterValue = @import("data_set_numeric_filter_value.zig").DataSetNumericFilterValue;

/// A filter condition that compares numeric values using operators like
/// `EQUALS`, `GREATER_THAN`,
/// or `LESS_THAN`.
pub const DataSetNumericComparisonFilterCondition = struct {
    /// The comparison operator to use, such as `EQUALS`, `GREATER_THAN`,
    /// `LESS_THAN`,
    /// or their variants.
    operator: DataSetNumericComparisonFilterOperator,

    /// The numeric value to compare against.
    value: ?DataSetNumericFilterValue,

    pub const json_field_names = .{
        .operator = "Operator",
        .value = "Value",
    };
};
