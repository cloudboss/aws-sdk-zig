const DataSetDateComparisonFilterOperator = @import("data_set_date_comparison_filter_operator.zig").DataSetDateComparisonFilterOperator;
const DataSetDateFilterValue = @import("data_set_date_filter_value.zig").DataSetDateFilterValue;

/// A filter condition that compares date values using operators like `BEFORE`,
/// `AFTER`, or
/// their inclusive variants.
pub const DataSetDateComparisonFilterCondition = struct {
    /// The comparison operator to use, such as `BEFORE`, `BEFORE_OR_EQUALS_TO`,
    /// `AFTER`,
    /// or `AFTER_OR_EQUALS_TO`.
    operator: DataSetDateComparisonFilterOperator,

    /// The date value to compare against.
    value: ?DataSetDateFilterValue,

    pub const json_field_names = .{
        .operator = "Operator",
        .value = "Value",
    };
};
