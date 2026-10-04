const DatasetEnrichmentEntry = @import("dataset_enrichment_entry.zig").DatasetEnrichmentEntry;

/// Contains the enrichment status information for a dataset across data types.
pub const DatasetEnrichment = struct {
    /// The enrichment status for video data in the dataset.
    video: ?DatasetEnrichmentEntry = null,

    pub const json_field_names = .{
        .video = "video",
    };
};
