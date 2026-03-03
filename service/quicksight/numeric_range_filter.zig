const AggregationFunction = @import("aggregation_function.zig").AggregationFunction;
const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;
const DefaultFilterControlConfiguration = @import("default_filter_control_configuration.zig").DefaultFilterControlConfiguration;
const FilterNullOption = @import("filter_null_option.zig").FilterNullOption;
const NumericRangeFilterValue = @import("numeric_range_filter_value.zig").NumericRangeFilterValue;
const NumericFilterSelectAllOptions = @import("numeric_filter_select_all_options.zig").NumericFilterSelectAllOptions;

/// A `NumericRangeFilter` filters values that are within the value range.
pub const NumericRangeFilter = struct {
    /// The aggregation function of the filter.
    aggregation_function: ?AggregationFunction = null,

    /// The column that the filter is applied to.
    column: ColumnIdentifier,

    /// The default configurations for the associated controls. This applies only
    /// for filters that are scoped to multiple sheets.
    default_filter_control_configuration: ?DefaultFilterControlConfiguration = null,

    /// An identifier that uniquely identifies a filter within a dashboard,
    /// analysis, or template.
    filter_id: []const u8,

    /// Determines whether the maximum value in the filter value range should be
    /// included in the filtered results.
    include_maximum: ?bool = null,

    /// Determines whether the minimum value in the filter value range should be
    /// included in the filtered results.
    include_minimum: ?bool = null,

    /// This option determines how null values should be treated when filtering
    /// data.
    ///
    /// * `ALL_VALUES`: Include null values in filtered results.
    ///
    /// * `NULLS_ONLY`: Only include null values in filtered results.
    ///
    /// * `NON_NULLS_ONLY`: Exclude null values from filtered results.
    null_option: FilterNullOption,

    /// The maximum value for the filter value range.
    range_maximum: ?NumericRangeFilterValue = null,

    /// The minimum value for the filter value range.
    range_minimum: ?NumericRangeFilterValue = null,

    /// Select all of the values. Null is not the assigned value of select all.
    ///
    /// * `FILTER_ALL_VALUES`
    select_all_options: ?NumericFilterSelectAllOptions = null,

    pub const json_field_names = .{
        .aggregation_function = "AggregationFunction",
        .column = "Column",
        .default_filter_control_configuration = "DefaultFilterControlConfiguration",
        .filter_id = "FilterId",
        .include_maximum = "IncludeMaximum",
        .include_minimum = "IncludeMinimum",
        .null_option = "NullOption",
        .range_maximum = "RangeMaximum",
        .range_minimum = "RangeMinimum",
        .select_all_options = "SelectAllOptions",
    };
};
