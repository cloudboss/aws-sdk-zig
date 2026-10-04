const TimeInNanos = @import("time_in_nanos.zig").TimeInNanos;

/// Contains information about a data segment entry to delete.
pub const DeleteDataSegmentEntry = struct {
    /// The nanosecond-precision end time of the data segment to delete.
    end_timestamp: TimeInNanos,

    /// The nanosecond-precision start time of the data segment to delete.
    start_timestamp: TimeInNanos,

    /// The ID of the time series.
    time_series_id: []const u8,

    pub const json_field_names = .{
        .end_timestamp = "endTimestamp",
        .start_timestamp = "startTimestamp",
        .time_series_id = "timeSeriesId",
    };
};
