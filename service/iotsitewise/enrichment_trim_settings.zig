const TimeInNanos = @import("time_in_nanos.zig").TimeInNanos;

/// Time range settings for extracting a specific window of video time-series
/// data to process.
///
/// Trim settings define the time bounds for enrichment and must satisfy:
///
/// * Start and end times must be within the dataset's time bounds
///
/// * Trim settings retrieve fully contained data segments within the specified
///   time range
///
/// * endTime must be greater than startTime
///
/// * Both times should represent valid data ranges in the dataset
///
/// Trim settings are required to:
///
/// * Prevent accidentally analyzing unbounded datasets
///
/// * Ensure predictable processing time and costs
///
/// * Allow focused analysis on specific time periods of interest
pub const EnrichmentTrimSettings = struct {
    /// End time for the video analysis time range in nanoseconds since Unix epoch
    /// (TimeInNanos format).
    /// Data segments at or before this time are included in the enrichment.
    /// Must be greater than startTime and within the dataset's time bounds.
    end_time: TimeInNanos,

    /// Start time for the video analysis time range in nanoseconds since Unix epoch
    /// (TimeInNanos format).
    /// Data segments at or after this time are included in the enrichment.
    /// Must be within the dataset's time bounds.
    ///
    /// Example (JavaScript): Date.parse('2024-01-01T00:00:00Z') * 1000000
    /// Example (Python): int(datetime.timestamp() * 1e9)
    start_time: TimeInNanos,

    pub const json_field_names = .{
        .end_time = "endTime",
        .start_time = "startTime",
    };
};
