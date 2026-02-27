const AnchorDateConfiguration = @import("anchor_date_configuration.zig").AnchorDateConfiguration;
const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;
const DefaultFilterControlConfiguration = @import("default_filter_control_configuration.zig").DefaultFilterControlConfiguration;
const ExcludePeriodConfiguration = @import("exclude_period_configuration.zig").ExcludePeriodConfiguration;
const TimeGranularity = @import("time_granularity.zig").TimeGranularity;
const FilterNullOption = @import("filter_null_option.zig").FilterNullOption;
const RelativeDateType = @import("relative_date_type.zig").RelativeDateType;

/// A `RelativeDatesFilter` filters relative dates values.
pub const RelativeDatesFilter = struct {
    /// The date configuration of the filter.
    anchor_date_configuration: AnchorDateConfiguration,

    /// The column that the filter is applied to.
    column: ColumnIdentifier,

    /// The default configurations for the associated controls. This applies only
    /// for filters that are scoped to multiple sheets.
    default_filter_control_configuration: ?DefaultFilterControlConfiguration,

    /// The configuration for the exclude period of the filter.
    exclude_period_configuration: ?ExcludePeriodConfiguration,

    /// An identifier that uniquely identifies a filter within a dashboard,
    /// analysis, or template.
    filter_id: []const u8,

    /// The minimum granularity (period granularity) of the relative dates filter.
    minimum_granularity: ?TimeGranularity,

    /// This option determines how null values should be treated when filtering
    /// data.
    ///
    /// * `ALL_VALUES`: Include null values in filtered results.
    ///
    /// * `NULLS_ONLY`: Only include null values in filtered results.
    ///
    /// * `NON_NULLS_ONLY`: Exclude null values from filtered results.
    null_option: FilterNullOption,

    /// The parameter whose value should be used for the filter value.
    parameter_name: ?[]const u8,

    /// The range date type of the filter. Choose one of the options below:
    ///
    /// * `PREVIOUS`
    ///
    /// * `THIS`
    ///
    /// * `LAST`
    ///
    /// * `NOW`
    ///
    /// * `NEXT`
    relative_date_type: RelativeDateType,

    /// The date value of the filter.
    relative_date_value: ?i32,

    /// The level of time precision that is used to aggregate `DateTime` values.
    time_granularity: TimeGranularity,

    pub const json_field_names = .{
        .anchor_date_configuration = "AnchorDateConfiguration",
        .column = "Column",
        .default_filter_control_configuration = "DefaultFilterControlConfiguration",
        .exclude_period_configuration = "ExcludePeriodConfiguration",
        .filter_id = "FilterId",
        .minimum_granularity = "MinimumGranularity",
        .null_option = "NullOption",
        .parameter_name = "ParameterName",
        .relative_date_type = "RelativeDateType",
        .relative_date_value = "RelativeDateValue",
        .time_granularity = "TimeGranularity",
    };
};
