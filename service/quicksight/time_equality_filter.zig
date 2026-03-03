const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;
const DefaultFilterControlConfiguration = @import("default_filter_control_configuration.zig").DefaultFilterControlConfiguration;
const RollingDateConfiguration = @import("rolling_date_configuration.zig").RollingDateConfiguration;
const TimeGranularity = @import("time_granularity.zig").TimeGranularity;

/// A `TimeEqualityFilter` filters values that are equal to a given value.
pub const TimeEqualityFilter = struct {
    /// The column that the filter is applied to.
    column: ColumnIdentifier,

    /// The default configurations for the associated controls. This applies only
    /// for filters that are scoped to multiple sheets.
    default_filter_control_configuration: ?DefaultFilterControlConfiguration = null,

    /// An identifier that uniquely identifies a filter within a dashboard,
    /// analysis, or template.
    filter_id: []const u8,

    /// The parameter whose value should be used for the filter value.
    ///
    /// This field is mutually exclusive to `Value` and `RollingDate`.
    parameter_name: ?[]const u8 = null,

    /// The rolling date input for the `TimeEquality` filter.
    ///
    /// This field is mutually exclusive to `Value` and `ParameterName`.
    rolling_date: ?RollingDateConfiguration = null,

    /// The level of time precision that is used to aggregate `DateTime` values.
    time_granularity: ?TimeGranularity = null,

    /// The value of a `TimeEquality` filter.
    ///
    /// This field is mutually exclusive to `RollingDate` and `ParameterName`.
    value: ?i64 = null,

    pub const json_field_names = .{
        .column = "Column",
        .default_filter_control_configuration = "DefaultFilterControlConfiguration",
        .filter_id = "FilterId",
        .parameter_name = "ParameterName",
        .rolling_date = "RollingDate",
        .time_granularity = "TimeGranularity",
        .value = "Value",
    };
};
