const EnrichmentStatus = @import("enrichment_status.zig").EnrichmentStatus;

/// Contains enrichment status information for a data segment.
pub const DataSegmentEnrichment = struct {
    /// The date the data segment was last enriched, in Unix epoch time.
    last_enriched_at: ?i64 = null,

    /// The enrichment status of the data segment.
    status: EnrichmentStatus,

    pub const json_field_names = .{
        .last_enriched_at = "lastEnrichedAt",
        .status = "status",
    };
};
