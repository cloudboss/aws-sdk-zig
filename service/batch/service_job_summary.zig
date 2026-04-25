const ServiceJobCapacityUsageSummary = @import("service_job_capacity_usage_summary.zig").ServiceJobCapacityUsageSummary;
const LatestServiceJobAttempt = @import("latest_service_job_attempt.zig").LatestServiceJobAttempt;
const ServiceJobType = @import("service_job_type.zig").ServiceJobType;
const ServiceJobStatus = @import("service_job_status.zig").ServiceJobStatus;

/// Summary information about a service job.
pub const ServiceJobSummary = struct {
    /// The capacity usage information for this service job, including the unit of
    /// measure and
    /// quantity of resources being used.
    capacity_usage: ?[]const ServiceJobCapacityUsageSummary = null,

    /// The Unix timestamp (in milliseconds) for when the service job was created.
    created_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the service job.
    job_arn: ?[]const u8 = null,

    /// The job ID for the service job.
    job_id: []const u8,

    /// The name of the service job.
    job_name: []const u8,

    /// Information about the latest attempt for the service job.
    latest_attempt: ?LatestServiceJobAttempt = null,

    /// The quota share for the service job.
    quota_share_name: ?[]const u8 = null,

    /// The Unix timestamp (in milliseconds) for when the service job was scheduled
    /// for
    /// execution.
    scheduled_at: ?i64 = null,

    /// The type of service job. For SageMaker Training jobs, this value is
    /// `SAGEMAKER_TRAINING`.
    service_job_type: ServiceJobType,

    /// The share identifier for the job.
    share_identifier: ?[]const u8 = null,

    /// The Unix timestamp (in milliseconds) for when the service job was started.
    started_at: ?i64 = null,

    /// The current status of the service job.
    status: ?ServiceJobStatus = null,

    /// A short string to provide more details on the current status of the service
    /// job.
    status_reason: ?[]const u8 = null,

    /// The Unix timestamp (in milliseconds) for when the service job stopped
    /// running.
    stopped_at: ?i64 = null,

    pub const json_field_names = .{
        .capacity_usage = "capacityUsage",
        .created_at = "createdAt",
        .job_arn = "jobArn",
        .job_id = "jobId",
        .job_name = "jobName",
        .latest_attempt = "latestAttempt",
        .quota_share_name = "quotaShareName",
        .scheduled_at = "scheduledAt",
        .service_job_type = "serviceJobType",
        .share_identifier = "shareIdentifier",
        .started_at = "startedAt",
        .status = "status",
        .status_reason = "statusReason",
        .stopped_at = "stoppedAt",
    };
};
