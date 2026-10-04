const TimeInNanos = @import("time_in_nanos.zig").TimeInNanos;
const DataSegmentErrorCode = @import("data_segment_error_code.zig").DataSegmentErrorCode;

/// Contains error information for a data segment association that failed.
pub const FailedDataSegmentAssociation = struct {
    /// The nanosecond-precision end time of the data segment.
    end_timestamp: TimeInNanos,

    /// The error code for the failed association.
    error_code: DataSegmentErrorCode,

    /// The error message for the failed association.
    error_message: []const u8,

    /// The ID of the source dataset.
    source_dataset_id: []const u8,

    /// The nanosecond-precision start time of the data segment.
    start_timestamp: TimeInNanos,

    /// The ID of the time series.
    time_series_id: []const u8,

    pub const json_field_names = .{
        .end_timestamp = "endTimestamp",
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .source_dataset_id = "sourceDatasetId",
        .start_timestamp = "startTimestamp",
        .time_series_id = "timeSeriesId",
    };
};
