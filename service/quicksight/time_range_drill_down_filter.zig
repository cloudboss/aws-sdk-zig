const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;
const TimeGranularity = @import("time_granularity.zig").TimeGranularity;

/// The time range drill down filter.
pub const TimeRangeDrillDownFilter = struct {
    /// The column that the filter is applied to.
    column: ColumnIdentifier,

    /// The maximum value for the filter value range.
    range_maximum: i64,

    /// The minimum value for the filter value range.
    range_minimum: i64,

    /// The level of time precision that is used to aggregate `DateTime` values.
    time_granularity: TimeGranularity,

    pub const json_field_names = .{
        .column = "Column",
        .range_maximum = "RangeMaximum",
        .range_minimum = "RangeMinimum",
        .time_granularity = "TimeGranularity",
    };
};
