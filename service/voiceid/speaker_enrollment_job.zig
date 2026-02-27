const EnrollmentConfig = @import("enrollment_config.zig").EnrollmentConfig;
const FailureDetails = @import("failure_details.zig").FailureDetails;
const InputDataConfig = @import("input_data_config.zig").InputDataConfig;
const JobProgress = @import("job_progress.zig").JobProgress;
const SpeakerEnrollmentJobStatus = @import("speaker_enrollment_job_status.zig").SpeakerEnrollmentJobStatus;
const OutputDataConfig = @import("output_data_config.zig").OutputDataConfig;

/// Contains all the information about a speaker enrollment job.
pub const SpeakerEnrollmentJob = struct {
    /// A timestamp of when the speaker enrollment job was created.
    created_at: ?i64,

    /// The IAM role Amazon Resource Name (ARN) that grants Voice ID permissions to
    /// access
    /// customer's buckets to read the input manifest file and write the job output
    /// file.
    data_access_role_arn: ?[]const u8,

    /// The identifier of the domain that contains the speaker enrollment job.
    domain_id: ?[]const u8,

    /// A timestamp of when the speaker enrollment job ended.
    ended_at: ?i64,

    /// The configuration that defines the action to take when the speaker is
    /// already enrolled
    /// in Voice ID, and the `FraudDetectionConfig` to use.
    enrollment_config: ?EnrollmentConfig,

    /// Contains details that are populated when an entire batch job fails. In cases
    /// of
    /// individual registration job failures, the batch job as a whole doesn't fail;
    /// it is
    /// completed with a `JobStatus` of `COMPLETED_WITH_ERRORS`. You can
    /// use the job output file to identify the individual registration requests
    /// that
    /// failed.
    failure_details: ?FailureDetails,

    /// The input data config containing an S3 URI for the input manifest file that
    /// contains
    /// the list of speaker enrollment job requests.
    input_data_config: ?InputDataConfig,

    /// The service-generated identifier for the speaker enrollment job.
    job_id: ?[]const u8,

    /// The client-provided name for the speaker enrollment job.
    job_name: ?[]const u8,

    /// Provides details on job progress. This field shows the completed percentage
    /// of
    /// registration requests listed in the input file.
    job_progress: ?JobProgress,

    /// The current status of the speaker enrollment job.
    job_status: ?SpeakerEnrollmentJobStatus,

    /// The output data config containing the S3 location where Voice ID writes the
    /// job
    /// output file; you must also include a KMS key ID to encrypt the
    /// file.
    output_data_config: ?OutputDataConfig,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .data_access_role_arn = "DataAccessRoleArn",
        .domain_id = "DomainId",
        .ended_at = "EndedAt",
        .enrollment_config = "EnrollmentConfig",
        .failure_details = "FailureDetails",
        .input_data_config = "InputDataConfig",
        .job_id = "JobId",
        .job_name = "JobName",
        .job_progress = "JobProgress",
        .job_status = "JobStatus",
        .output_data_config = "OutputDataConfig",
    };
};
