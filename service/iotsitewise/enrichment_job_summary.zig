const JobType = @import("job_type.zig").JobType;
const EnrichmentJobStatus = @import("enrichment_job_status.zig").EnrichmentJobStatus;

/// Summary information for an enrichment job returned by ListEnrichmentJobs.
/// This lightweight
/// representation includes identifiers, status, and key metadata without the
/// full job configuration.
///
/// Use DescribeEnrichmentJob to retrieve:
///
/// * Complete job configuration (trim settings, full parameters)
///
/// * Detailed timestamps (completedAt, cancelledAt)
///
/// * Failure messages for failed jobs
///
/// The summary is optimized for display in lists and dashboards, providing
/// enough information to
/// identify and filter jobs without the overhead of full configuration details.
pub const EnrichmentJobSummary = struct {
    /// Timestamp when the job was created in ISO 8601 format.
    created_at: i64,

    /// The dataset being enriched. Useful for filtering and identifying jobs
    /// without fetching the full
    /// configuration. This allows you to quickly find all jobs related to a
    /// specific dataset.
    dataset_id: []const u8,

    /// Unique identifier for the enrichment job.
    job_id: []const u8,

    /// The type of enrichment job. Currently EVENT_DETECTION is the only supported
    /// type.
    job_type: JobType,

    /// The property alias (human-readable sensor name) of the time series being
    /// enriched.
    /// Present when the job was created using a propertyAlias. Use this to identify
    /// which sensor the job analyzes.
    property_alias: ?[]const u8 = null,

    /// Current status of the job: PENDING, RUNNING, COMPLETED, FAILED, TIMED_OUT,
    /// or CANCELLED.
    /// Use this to quickly identify active jobs or jobs requiring attention.
    status: EnrichmentJobStatus,

    /// The system identifier of the time series being enriched.
    /// Present when the job was created using a timeSeriesId. Use this to identify
    /// which time series the job analyzes.
    time_series_id: ?[]const u8 = null,

    /// Timestamp of the last job status change in ISO 8601 format. Use this to
    /// track recent activity
    /// and identify stale jobs. For active jobs, this shows the last time the job
    /// transitioned to a new status.
    updated_at: ?i64 = null,

    /// The name of the IoT SiteWise workspace containing this job.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .dataset_id = "datasetId",
        .job_id = "jobId",
        .job_type = "jobType",
        .property_alias = "propertyAlias",
        .status = "status",
        .time_series_id = "timeSeriesId",
        .updated_at = "updatedAt",
        .workspace_name = "workspaceName",
    };
};
