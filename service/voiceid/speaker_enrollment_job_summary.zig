const FailureDetails = @import("failure_details.zig").FailureDetails;
const JobProgress = @import("job_progress.zig").JobProgress;
const SpeakerEnrollmentJobStatus = @import("speaker_enrollment_job_status.zig").SpeakerEnrollmentJobStatus;

/// Contains a summary of information about a speaker enrollment job.
pub const SpeakerEnrollmentJobSummary = struct {
    /// A timestamp of when of the speaker enrollment job was created.
    created_at: ?i64 = null,

    /// The identifier of the domain that contains the speaker enrollment job.
    domain_id: ?[]const u8 = null,

    /// A timestamp of when the speaker enrollment job ended.
    ended_at: ?i64 = null,

    /// Contains details that are populated when an entire batch job fails. In cases
    /// of
    /// individual registration job failures, the batch job as a whole doesn't fail;
    /// it is
    /// completed with a `JobStatus` of `COMPLETED_WITH_ERRORS`. You can
    /// use the job output file to identify the individual registration requests
    /// that
    /// failed.
    failure_details: ?FailureDetails = null,

    /// The service-generated identifier for the speaker enrollment job.
    job_id: ?[]const u8 = null,

    /// The client-provided name for the speaker enrollment job.
    job_name: ?[]const u8 = null,

    /// Provides details regarding job progress. This field shows the completed
    /// percentage of
    /// enrollment requests listed in the input file.
    job_progress: ?JobProgress = null,

    /// The current status of the speaker enrollment job.
    job_status: ?SpeakerEnrollmentJobStatus = null,

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
