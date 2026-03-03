const DataSetDateComparisonFilterCondition = @import("data_set_date_comparison_filter_condition.zig").DataSetDateComparisonFilterCondition;
const DataSetDateRangeFilterCondition = @import("data_set_date_range_filter_condition.zig").DataSetDateRangeFilterCondition;

/// A filter condition for date columns, supporting both comparison and
/// range-based filtering.
pub const DataSetDateFilterCondition = struct {
    /// The name of the date column to filter.
    column_name: ?[]const u8 = null,

    /// A comparison-based filter condition for the date column.
    comparison_filter_condition: ?DataSetDateComparisonFilterCondition = null,

    /// A range-based filter condition for the date column, filtering values between
    /// minimum and maximum dates.
    range_filter_condition: ?DataSetDateRangeFilterCondition = null,

    pub const json_field_names = .{
        .column_name = "ColumnName",
        .comparison_filter_condition = "ComparisonFilterCondition",
        .range_filter_condition = "RangeFilterCondition",
    };
};
