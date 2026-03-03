const DataSetStringComparisonFilterOperator = @import("data_set_string_comparison_filter_operator.zig").DataSetStringComparisonFilterOperator;
const DataSetStringFilterValue = @import("data_set_string_filter_value.zig").DataSetStringFilterValue;

/// A filter condition that compares string values using operators like
/// `EQUALS`, `CONTAINS`,
/// or `STARTS_WITH`.
pub const DataSetStringComparisonFilterCondition = struct {
    /// The comparison operator to use, such as `EQUALS`, `CONTAINS`, `STARTS_WITH`,
    /// `ENDS_WITH`, or their negations.
    operator: DataSetStringComparisonFilterOperator,

    /// The string value to compare against.
    value: ?DataSetStringFilterValue = null,

    pub const json_field_names = .{
        .operator = "Operator",
        .value = "Value",
    };
};
