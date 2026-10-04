const EnrichmentTrimSettings = @import("enrichment_trim_settings.zig").EnrichmentTrimSettings;

/// Configuration for event detection enrichment on video time-series data.
///
/// Event detection generates embeddings from video data enabling natural
/// language similarity search
/// on events. This allows customers to:
///
/// * Query video events using semantic search after enrichment completes
///
/// * Find relevant video segments through natural language queries
///
/// * Search across video time-series data stored in IoT SiteWise
///
/// You must specify the dataset, exactly one time-series identifier
/// (timeSeriesId OR propertyAlias),
/// and trim settings defining the video time window to process.
pub const EventDetection = struct {
    /// The IoT SiteWise dataset ID containing the video time-series data to
    /// analyze.
    /// Query IoT SiteWise to discover available datasets in your workspace.
    dataset_id: []const u8,

    /// Human-readable alias for the video time series to analyze (e.g.,
    /// /camera/warehouse/zone-a).
    /// Specify either propertyAlias or timeSeriesId, but not both.
    /// Use this when you have configured friendly aliases in IoT SiteWise for
    /// better readability.
    property_alias: ?[]const u8 = null,

    /// Unique system identifier for the video time series to analyze.
    /// Specify either timeSeriesId or propertyAlias, but not both.
    /// Use this when you have the system-generated time series identifier from IoT
    /// SiteWise.
    time_series_id: ?[]const u8 = null,

    /// Time range settings defining which portion of the video time-series data to
    /// process.
    /// Required to ensure predictable processing time and prevent analyzing
    /// unbounded datasets.
    /// Start and end times must be within the dataset's time bounds.
    trim_settings: EnrichmentTrimSettings,

    pub const json_field_names = .{
        .dataset_id = "datasetId",
        .property_alias = "propertyAlias",
        .time_series_id = "timeSeriesId",
        .trim_settings = "trimSettings",
    };
};
