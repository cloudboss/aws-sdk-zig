const FailureDetails = @import("failure_details.zig").FailureDetails;
const JobProgress = @import("job_progress.zig").JobProgress;
const FraudsterRegistrationJobStatus = @import("fraudster_registration_job_status.zig").FraudsterRegistrationJobStatus;

/// Contains a summary of information about a fraudster registration job.
pub const FraudsterRegistrationJobSummary = struct {
    /// A timestamp of when the fraudster registration job was created.
    created_at: ?i64,

    /// The identifier of the domain that contains the fraudster registration job.
    domain_id: ?[]const u8,

    /// A timestamp of when the fraudster registration job ended.
    ended_at: ?i64,

    /// Contains details that are populated when an entire batch job fails. In cases
    /// of
    /// individual registration job failures, the batch job as a whole doesn't fail;
    /// it is
    /// completed with a `JobStatus` of `COMPLETED_WITH_ERRORS`. You can
    /// use the job output file to identify the individual registration requests
    /// that
    /// failed.
    failure_details: ?FailureDetails,

    /// The service-generated identifier for the fraudster registration job.
    job_id: ?[]const u8,

    /// The client-provided name for the fraudster registration job.
    job_name: ?[]const u8,

    /// Shows the completed percentage of registration requests listed in the input
    /// file.
    job_progress: ?JobProgress,

    /// The current status of the fraudster registration job.
    job_status: ?FraudsterRegistrationJobStatus,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .domain_id = "DomainId",
        .ended_at = "EndedAt",
        .failure_details = "FailureDetails",
        .job_id = "JobId",
        .job_name = "JobName",
        .job_progress = "JobProgress",
        .job_status = "JobStatus",
    };
};
