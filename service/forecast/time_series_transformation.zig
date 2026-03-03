const Action = @import("action.zig").Action;
const TimeSeriesCondition = @import("time_series_condition.zig").TimeSeriesCondition;

/// A transformation function is a pair of operations that select and modify the
/// rows in a related time series. You select the rows that you want with a
/// condition operation and you modify the rows with a transformation operation.
/// All conditions are joined with an AND operation, meaning that all conditions
/// must be true for the transformation to be applied. Transformations are
/// applied in the order that they are listed.
pub const TimeSeriesTransformation = struct {
    /// An array of actions that define a time series and how it is transformed.
    /// These transformations create a new
    /// time series that is used for the what-if analysis.
    action: ?Action = null,

    /// An array of conditions that define which members of the related time series
    /// are transformed.
    time_series_conditions: ?[]const TimeSeriesCondition = null,

    pub const json_field_names = .{
        .action = "Action",
        .time_series_conditions = "TimeSeriesConditions",
    };
};
