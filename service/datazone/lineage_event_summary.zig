const EventSummary = @import("event_summary.zig").EventSummary;
const LineageEventProcessingStatus = @import("lineage_event_processing_status.zig").LineageEventProcessingStatus;

/// The data lineage event summary.
pub const LineageEventSummary = struct {
    /// The timestamp at which data lineage event was created.
    created_at: ?i64 = null,

    /// The user who created the data lineage event.
    created_by: ?[]const u8 = null,

    /// The domain ID of the lineage event.
    domain_id: ?[]const u8 = null,

    /// The summary of the data lineate event.
    event_summary: ?EventSummary = null,

    /// The time of the data lineage event.
    event_time: ?i64 = null,

    /// The ID of the data lineage event.
    id: ?[]const u8 = null,

    /// The processing status of the data lineage event.
    processing_status: ?LineageEventProcessingStatus = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .domain_id = "domainId",
        .event_summary = "eventSummary",
        .event_time = "eventTime",
        .id = "id",
        .processing_status = "processingStatus",
    };
};
