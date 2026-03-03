const AutoAdjustType = @import("auto_adjust_type.zig").AutoAdjustType;
const HistoricalOptions = @import("historical_options.zig").HistoricalOptions;

/// The parameters that determine the budget amount for an auto-adjusting
/// budget.
pub const AutoAdjustData = struct {
    /// The string that defines whether your budget auto-adjusts based on historical
    /// or
    /// forecasted data.
    auto_adjust_type: AutoAdjustType,

    /// The parameters that define or describe the historical data that your
    /// auto-adjusting
    /// budget is based on.
    historical_options: ?HistoricalOptions = null,

    /// The last time that your budget was auto-adjusted.
    last_auto_adjust_time: ?i64 = null,

    pub const json_field_names = .{
        .auto_adjust_type = "AutoAdjustType",
        .historical_options = "HistoricalOptions",
        .last_auto_adjust_time = "LastAutoAdjustTime",
    };
};
