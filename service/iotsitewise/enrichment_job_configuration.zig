const EventDetection = @import("event_detection.zig").EventDetection;

/// Configuration for the enrichment job defining which analysis type to perform
/// on video time-series data.
/// Currently supports event detection enrichment. Exactly one member must be
/// specified.
pub const EnrichmentJobConfiguration = union(enum) {
    /// Event detection configuration that generates embeddings from video
    /// time-series data enabling
    /// natural language similarity search on events. The service processes video
    /// data and creates
    /// embeddings stored in IoT SiteWise for semantic querying.
    event_detection: ?EventDetection,

    pub const json_field_names = .{
        .event_detection = "eventDetection",
    };
};
