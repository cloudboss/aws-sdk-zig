const AggregationSortConfiguration = @import("aggregation_sort_configuration.zig").AggregationSortConfiguration;
const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;
const DefaultFilterControlConfiguration = @import("default_filter_control_configuration.zig").DefaultFilterControlConfiguration;
const TimeGranularity = @import("time_granularity.zig").TimeGranularity;

/// A `TopBottomFilter` filters values that are at the top or the bottom.
pub const TopBottomFilter = struct {
    /// The aggregation and sort configuration of the top bottom filter.
    aggregation_sort_configurations: []const AggregationSortConfiguration,

    /// The column that the filter is applied to.
    column: ColumnIdentifier,

    /// The default configurations for the associated controls. This applies only
    /// for filters that are scoped to multiple sheets.
    default_filter_control_configuration: ?DefaultFilterControlConfiguration = null,

    /// An identifier that uniquely identifies a filter within a dashboard,
    /// analysis, or template.
    filter_id: []const u8,

    /// The number of items to include in the top bottom filter results.
    limit: ?i32 = null,

    /// The parameter whose value should be used for the filter value.
    parameter_name: ?[]const u8 = null,

    /// The level of time precision that is used to aggregate `DateTime` values.
    time_granularity: ?TimeGranularity = null,

    pub const json_field_names = .{
        .aggregation_sort_configurations = "AggregationSortConfigurations",
        .column = "Column",
        .default_filter_control_configuration = "DefaultFilterControlConfiguration",
        .filter_id = "FilterId",
        .limit = "Limit",
        .parameter_name = "ParameterName",
        .time_granularity = "TimeGranularity",
    };
};
