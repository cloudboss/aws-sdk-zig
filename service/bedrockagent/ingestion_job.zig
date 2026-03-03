const IngestionJobStatistics = @import("ingestion_job_statistics.zig").IngestionJobStatistics;
const IngestionJobStatus = @import("ingestion_job_status.zig").IngestionJobStatus;

/// Contains details about a data ingestion job. Data sources are ingested into
/// a knowledge base so that Large Language Models (LLMs) can use your data.
///
/// This data type is used in the following API operations:
///
/// * [StartIngestionJob
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_StartIngestionJob.html#API_agent_StartIngestionJob_ResponseSyntax)
/// * [GetIngestionJob
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_GetIngestionJob.html#API_agent_GetIngestionJob_ResponseSyntax)
/// * [ListIngestionJob
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_ListIngestionJobs.html#API_agent_ListIngestionJobs_ResponseSyntax)
pub const IngestionJob = struct {
    /// The unique identifier of the data source for the data ingestion job.
    data_source_id: []const u8,

    /// The description of the data ingestion job.
    description: ?[]const u8 = null,

    /// A list of reasons that the data ingestion job failed.
    failure_reasons: ?[]const []const u8 = null,

    /// The unique identifier of the data ingestion job.
    ingestion_job_id: []const u8,

    /// The unique identifier of the knowledge for the data ingestion job.
    knowledge_base_id: []const u8,

    /// The time the data ingestion job started.
    ///
    /// If you stop a data ingestion job, the `startedAt` time is the time the job
    /// was started before the job was stopped.
    started_at: i64,

    /// Contains statistics about the data ingestion job.
    statistics: ?IngestionJobStatistics = null,

    /// The status of the data ingestion job.
    status: IngestionJobStatus,

    /// The time the data ingestion job was last updated.
    ///
    /// If you stop a data ingestion job, the `updatedAt` time is the time the job
    /// was stopped.
    updated_at: i64,

    pub const json_field_names = .{
        .data_source_id = "dataSourceId",
        .description = "description",
        .failure_reasons = "failureReasons",
        .ingestion_job_id = "ingestionJobId",
        .knowledge_base_id = "knowledgeBaseId",
        .started_at = "startedAt",
        .statistics = "statistics",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
