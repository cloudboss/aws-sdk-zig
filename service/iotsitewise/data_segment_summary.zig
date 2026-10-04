const PropertyDataType = @import("property_data_type.zig").PropertyDataType;
const TimeInNanos = @import("time_in_nanos.zig").TimeInNanos;
const DataSegmentEnrichment = @import("data_segment_enrichment.zig").DataSegmentEnrichment;

/// Contains summary information about a data segment, including its source
/// dataset, time
/// series, timestamp range, and enrichment status.
pub const DataSegmentSummary = struct {
    /// The alias of the time series.
    alias: []const u8,

    /// The data type of the time series.
    data_type: PropertyDataType,

    /// The nanosecond-precision end time of the data segment.
    end_timestamp: TimeInNanos,

    /// The enrichment information for the data segment.
    enrichment: ?DataSegmentEnrichment = null,

    /// The ID of the source dataset that contains the data segment.
    source_dataset_id: []const u8,

    /// The nanosecond-precision start time of the data segment.
    start_timestamp: TimeInNanos,

    /// The ID of the time series.
    time_series_id: []const u8,

    pub const json_field_names = .{
        .alias = "alias",
        .data_type = "dataType",
        .end_timestamp = "endTimestamp",
        .enrichment = "enrichment",
        .source_dataset_id = "sourceDatasetId",
        .start_timestamp = "startTimestamp",
        .time_series_id = "timeSeriesId",
    };
};
