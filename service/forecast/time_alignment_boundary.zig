const DayOfWeek = @import("day_of_week.zig").DayOfWeek;
const Month = @import("month.zig").Month;

/// The time boundary Forecast uses to align and aggregate your data to match
/// your forecast frequency. Provide the unit of time and the time boundary as a
/// key value pair. If you
/// don't provide a time boundary, Forecast uses a set of [Default Time
/// Boundaries](https://docs.aws.amazon.com/forecast/latest/dg/data-aggregation.html#default-time-boundaries).
///
/// For more information about aggregation,
/// see [Data Aggregation for Different Forecast
/// Frequencies](https://docs.aws.amazon.com/forecast/latest/dg/data-aggregation.html).
/// For more information setting a custom time boundary,
/// see [Specifying a Time
/// Boundary](https://docs.aws.amazon.com/forecast/latest/dg/data-aggregation.html#specifying-time-boundary).
pub const TimeAlignmentBoundary = struct {
    /// The day of the month to use for time alignment during aggregation.
    day_of_month: ?i32 = null,

    /// The day of week to use for time alignment during aggregation. The day must
    /// be in uppercase.
    day_of_week: ?DayOfWeek = null,

    /// The hour of day to use for time alignment during aggregation.
    hour: ?i32 = null,

    /// The month to use for time alignment during aggregation. The month must be in
    /// uppercase.
    month: ?Month = null,

    pub const json_field_names = .{
        .day_of_month = "DayOfMonth",
        .day_of_week = "DayOfWeek",
        .hour = "Hour",
        .month = "Month",
    };
};
