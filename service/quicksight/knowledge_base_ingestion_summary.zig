const KbIngestionStatus = @import("kb_ingestion_status.zig").KbIngestionStatus;

/// A summary of an ingestion job for a knowledge base.
pub const KnowledgeBaseIngestionSummary = struct {
    /// The end time of the ingestion job.
    end_time: ?i64 = null,

    /// The unique identifier for the ingestion job.
    ingestion_id: []const u8,

    /// The status of the ingestion job.
    ingestion_status: KbIngestionStatus,

    /// The start time of the ingestion job.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .ingestion_id = "IngestionId",
        .ingestion_status = "IngestionStatus",
        .start_time = "StartTime",
    };
};
