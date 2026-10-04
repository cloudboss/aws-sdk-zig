const DatasetEnrichmentStatus = @import("dataset_enrichment_status.zig").DatasetEnrichmentStatus;

/// Contains enrichment status information for a specific data type in a
/// dataset.
pub const DatasetEnrichmentEntry = struct {
    /// The date the data was last enriched, in Unix epoch time.
    last_enriched_at: ?i64 = null,

    /// The enrichment status of the data type in the dataset.
    status: DatasetEnrichmentStatus,

    pub const json_field_names = .{
        .last_enriched_at = "lastEnrichedAt",
        .status = "status",
    };
};
