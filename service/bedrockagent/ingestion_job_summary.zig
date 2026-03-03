const IngestionJobStatistics = @import("ingestion_job_statistics.zig").IngestionJobStatistics;
const IngestionJobStatus = @import("ingestion_job_status.zig").IngestionJobStatus;

/// Contains details about a data ingestion job.
pub const IngestionJobSummary = struct {
    /// The unique identifier of the data source for the data ingestion job.
    data_source_id: []const u8,

    /// The description of the data ingestion job.
    description: ?[]const u8 = null,

    /// The unique identifier of the data ingestion job.
    ingestion_job_id: []const u8,

    /// The unique identifier of the knowledge base for the data ingestion job.
    knowledge_base_id: []const u8,

    /// The time the data ingestion job started.
    started_at: i64,

    /// Contains statistics for the data ingestion job.
    statistics: ?IngestionJobStatistics = null,

    /// The status of the data ingestion job.
    status: IngestionJobStatus,

    /// The time the data ingestion job was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .data_source_id = "dataSourceId",
        .description = "description",
        .ingestion_job_id = "ingestionJobId",
        .knowledge_base_id = "knowledgeBaseId",
        .started_at = "startedAt",
        .statistics = "statistics",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
