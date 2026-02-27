const DateTimeValue = @import("date_time_value.zig").DateTimeValue;

/// Defines a time period with explicit start and end times for data queries.
pub const DateTimeRange = struct {
    /// The end time of the date range for querying data.
    end_time: DateTimeValue,

    /// The start time of the date range for querying data.
    start_time: DateTimeValue,

    pub const json_field_names = .{
        .end_time = "endTime",
        .start_time = "startTime",
    };
};
