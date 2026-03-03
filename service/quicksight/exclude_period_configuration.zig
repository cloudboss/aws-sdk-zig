const TimeGranularity = @import("time_granularity.zig").TimeGranularity;
const WidgetStatus = @import("widget_status.zig").WidgetStatus;

/// The exclude period of `TimeRangeFilter` or `RelativeDatesFilter`.
pub const ExcludePeriodConfiguration = struct {
    /// The amount or number of the exclude period.
    amount: i32,

    /// The granularity or unit (day, month, year) of the exclude period.
    granularity: TimeGranularity,

    /// The status of the exclude period. Choose from the following options:
    ///
    /// * `ENABLED`
    ///
    /// * `DISABLED`
    status: ?WidgetStatus = null,

    pub const json_field_names = .{
        .amount = "Amount",
        .granularity = "Granularity",
        .status = "Status",
    };
};
