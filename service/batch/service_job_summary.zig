const LatestServiceJobAttempt = @import("latest_service_job_attempt.zig").LatestServiceJobAttempt;
const ServiceJobType = @import("service_job_type.zig").ServiceJobType;
const ServiceJobStatus = @import("service_job_status.zig").ServiceJobStatus;

/// Summary information about a service job.
pub const ServiceJobSummary = struct {
    /// The Unix timestamp (in milliseconds) for when the service job was created.
    created_at: ?i64,

    /// The Amazon Resource Name (ARN) of the service job.
    job_arn: ?[]const u8,

    /// The job ID for the service job.
    job_id: []const u8,

    /// The name of the service job.
    job_name: []const u8,

    /// Information about the latest attempt for the service job.
    latest_attempt: ?LatestServiceJobAttempt,

    /// The type of service job. For SageMaker Training jobs, this value is
    /// `SAGEMAKER_TRAINING`.
    service_job_type: ServiceJobType,

    /// The share identifier for the job.
    share_identifier: ?[]const u8,

    /// The Unix timestamp (in milliseconds) for when the service job was started.
    started_at: ?i64,

    /// The current status of the service job.
    status: ?ServiceJobStatus,

    /// A short string to provide more details on the current status of the service
    /// job.
    status_reason: ?[]const u8,

    /// The Unix timestamp (in milliseconds) for when the service job stopped
    /// running.
    stopped_at: ?i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .job_arn = "jobArn",
        .job_id = "jobId",
        .job_name = "jobName",
        .latest_attempt = "latestAttempt",
        .service_job_type = "serviceJobType",
        .share_identifier = "shareIdentifier",
        .started_at = "startedAt",
        .status = "status",
        .status_reason = "statusReason",
        .stopped_at = "stoppedAt",
    };
};
