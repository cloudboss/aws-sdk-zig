const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;
const DefaultFilterControlConfiguration = @import("default_filter_control_configuration.zig").DefaultFilterControlConfiguration;
const ExcludePeriodConfiguration = @import("exclude_period_configuration.zig").ExcludePeriodConfiguration;
const FilterNullOption = @import("filter_null_option.zig").FilterNullOption;
const TimeRangeFilterValue = @import("time_range_filter_value.zig").TimeRangeFilterValue;
const TimeGranularity = @import("time_granularity.zig").TimeGranularity;

/// A `TimeRangeFilter` filters values that are between two specified values.
pub const TimeRangeFilter = struct {
    /// The column that the filter is applied to.
    column: ColumnIdentifier,

    /// The default configurations for the associated controls. This applies only
    /// for filters that are scoped to multiple sheets.
    default_filter_control_configuration: ?DefaultFilterControlConfiguration,

    /// The exclude period of the time range filter.
    exclude_period_configuration: ?ExcludePeriodConfiguration,

    /// An identifier that uniquely identifies a filter within a dashboard,
    /// analysis, or template.
    filter_id: []const u8,

    /// Determines whether the maximum value in the filter value range should be
    /// included in the filtered results.
    include_maximum: ?bool,

    /// Determines whether the minimum value in the filter value range should be
    /// included in the filtered results.
    include_minimum: ?bool,

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
    range_maximum_value: ?TimeRangeFilterValue,

    /// The minimum value for the filter value range.
    range_minimum_value: ?TimeRangeFilterValue,

    /// The level of time precision that is used to aggregate `DateTime` values.
    time_granularity: ?TimeGranularity,

    pub const json_field_names = .{
        .column = "Column",
        .default_filter_control_configuration = "DefaultFilterControlConfiguration",
        .exclude_period_configuration = "ExcludePeriodConfiguration",
        .filter_id = "FilterId",
        .include_maximum = "IncludeMaximum",
        .include_minimum = "IncludeMinimum",
        .null_option = "NullOption",
        .range_maximum_value = "RangeMaximumValue",
        .range_minimum_value = "RangeMinimumValue",
        .time_granularity = "TimeGranularity",
    };
};
