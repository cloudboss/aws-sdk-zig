const TimeInNanos = @import("time_in_nanos.zig").TimeInNanos;

/// Contains summary information about a data segment relationship between a
/// source session
/// dataset that contains the data and a curated dataset that references it,
/// including the time
/// series and timestamp range.
pub const DataSegmentRelationshipSummary = struct {
    /// The nanosecond-precision end time of the data segment.
    end_timestamp: TimeInNanos,

    /// The ID of the source session dataset that contains the data segment.
    source_dataset_id: []const u8,

    /// The nanosecond-precision start time of the data segment.
    start_timestamp: TimeInNanos,

    /// The ID of the curated dataset that references the data segment.
    target_dataset_id: []const u8,

    /// The ID of the time series.
    time_series_id: []const u8,

    pub const json_field_names = .{
        .end_timestamp = "endTimestamp",
        .source_dataset_id = "sourceDatasetId",
        .start_timestamp = "startTimestamp",
        .target_dataset_id = "targetDatasetId",
        .time_series_id = "timeSeriesId",
    };
};
