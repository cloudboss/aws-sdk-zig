const DataSetDateFilterValue = @import("data_set_date_filter_value.zig").DataSetDateFilterValue;

/// A filter condition that filters date values within a specified range.
pub const DataSetDateRangeFilterCondition = struct {
    /// Whether to include the maximum value in the filter range.
    include_maximum: ?bool,

    /// Whether to include the minimum value in the filter range.
    include_minimum: ?bool,

    /// The maximum date value for the range filter.
    range_maximum: ?DataSetDateFilterValue,

    /// The minimum date value for the range filter.
    range_minimum: ?DataSetDateFilterValue,

    pub const json_field_names = .{
        .include_maximum = "IncludeMaximum",
        .include_minimum = "IncludeMinimum",
        .range_maximum = "RangeMaximum",
        .range_minimum = "RangeMinimum",
    };
};
