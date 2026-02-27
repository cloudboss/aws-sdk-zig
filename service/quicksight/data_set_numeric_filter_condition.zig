const DataSetNumericComparisonFilterCondition = @import("data_set_numeric_comparison_filter_condition.zig").DataSetNumericComparisonFilterCondition;
const DataSetNumericRangeFilterCondition = @import("data_set_numeric_range_filter_condition.zig").DataSetNumericRangeFilterCondition;

/// A filter condition for numeric columns, supporting both comparison and
/// range-based filtering.
pub const DataSetNumericFilterCondition = struct {
    /// The name of the numeric column to filter.
    column_name: ?[]const u8,

    /// A comparison-based filter condition for the numeric column.
    comparison_filter_condition: ?DataSetNumericComparisonFilterCondition,

    /// A range-based filter condition for the numeric column, filtering values
    /// between minimum and maximum numbers.
    range_filter_condition: ?DataSetNumericRangeFilterCondition,

    pub const json_field_names = .{
        .column_name = "ColumnName",
        .comparison_filter_condition = "ComparisonFilterCondition",
        .range_filter_condition = "RangeFilterCondition",
    };
};
