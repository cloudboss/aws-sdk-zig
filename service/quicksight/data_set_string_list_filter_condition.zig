const DataSetStringListFilterOperator = @import("data_set_string_list_filter_operator.zig").DataSetStringListFilterOperator;
const DataSetStringListFilterValue = @import("data_set_string_list_filter_value.zig").DataSetStringListFilterValue;

/// A filter condition that includes or excludes string values from a specified
/// list.
pub const DataSetStringListFilterCondition = struct {
    /// The list operator to use, either `INCLUDE` to match values in the list or
    /// `EXCLUDE` to
    /// filter out values in the list.
    operator: DataSetStringListFilterOperator,

    /// The list of string values to include or exclude in the filter.
    values: ?DataSetStringListFilterValue,

    pub const json_field_names = .{
        .operator = "Operator",
        .values = "Values",
    };
};
