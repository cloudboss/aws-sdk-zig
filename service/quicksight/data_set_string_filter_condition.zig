const DataSetStringComparisonFilterCondition = @import("data_set_string_comparison_filter_condition.zig").DataSetStringComparisonFilterCondition;
const DataSetStringListFilterCondition = @import("data_set_string_list_filter_condition.zig").DataSetStringListFilterCondition;

/// A filter condition for string columns, supporting both comparison and
/// list-based filtering.
pub const DataSetStringFilterCondition = struct {
    /// The name of the string column to filter.
    column_name: ?[]const u8,

    /// A comparison-based filter condition for the string column.
    comparison_filter_condition: ?DataSetStringComparisonFilterCondition,

    /// A list-based filter condition that includes or excludes values from a
    /// specified list.
    list_filter_condition: ?DataSetStringListFilterCondition,

    pub const json_field_names = .{
        .column_name = "ColumnName",
        .comparison_filter_condition = "ComparisonFilterCondition",
        .list_filter_condition = "ListFilterCondition",
    };
};
