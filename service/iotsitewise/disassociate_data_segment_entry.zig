const TimeInNanos = @import("time_in_nanos.zig").TimeInNanos;

/// Contains information about a data segment entry to disassociate from a
/// dataset.
pub const DisassociateDataSegmentEntry = struct {
    /// The nanosecond-precision end time of the data segment to disassociate.
    end_timestamp: TimeInNanos,

    /// The ID of the source dataset that contains the data segment.
    source_dataset_id: []const u8,

    /// The nanosecond-precision start time of the data segment to disassociate.
    start_timestamp: TimeInNanos,

    /// The ID of the time series.
    time_series_id: []const u8,

    pub const json_field_names = .{
        .end_timestamp = "endTimestamp",
        .source_dataset_id = "sourceDatasetId",
        .start_timestamp = "startTimestamp",
        .time_series_id = "timeSeriesId",
    };
};
