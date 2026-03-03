const DataSetNumericFilterValue = @import("data_set_numeric_filter_value.zig").DataSetNumericFilterValue;

/// A filter condition that filters numeric values within a specified range.
pub const DataSetNumericRangeFilterCondition = struct {
    /// Whether to include the maximum value in the filter range.
    include_maximum: ?bool = null,

    /// Whether to include the minimum value in the filter range.
    include_minimum: ?bool = null,

    /// The maximum numeric value for the range filter.
    range_maximum: ?DataSetNumericFilterValue = null,

    /// The minimum numeric value for the range filter.
    range_minimum: ?DataSetNumericFilterValue = null,

    pub const json_field_names = .{
        .include_maximum = "IncludeMaximum",
        .include_minimum = "IncludeMinimum",
        .range_maximum = "RangeMaximum",
        .range_minimum = "RangeMinimum",
    };
};
