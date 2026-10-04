const TimeInNanos = @import("time_in_nanos.zig").TimeInNanos;
const DataSegmentErrorCode = @import("data_segment_error_code.zig").DataSegmentErrorCode;

/// Contains error information for a data segment deletion that failed.
pub const FailedDataSegmentDeletion = struct {
    /// The nanosecond-precision end time of the data segment.
    end_timestamp: TimeInNanos,

    /// The error code for the failed deletion.
    error_code: DataSegmentErrorCode,

    /// The error message for the failed deletion.
    error_message: []const u8,

    /// The nanosecond-precision start time of the data segment.
    start_timestamp: TimeInNanos,

    /// The ID of the time series.
    time_series_id: []const u8,

    pub const json_field_names = .{
        .end_timestamp = "endTimestamp",
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .start_timestamp = "startTimestamp",
        .time_series_id = "timeSeriesId",
    };
};
