const FailureDetails = @import("failure_details.zig").FailureDetails;
const InputDataConfig = @import("input_data_config.zig").InputDataConfig;
const JobProgress = @import("job_progress.zig").JobProgress;
const FraudsterRegistrationJobStatus = @import("fraudster_registration_job_status.zig").FraudsterRegistrationJobStatus;
const OutputDataConfig = @import("output_data_config.zig").OutputDataConfig;
const RegistrationConfig = @import("registration_config.zig").RegistrationConfig;

/// Contains all the information about a fraudster registration job.
pub const FraudsterRegistrationJob = struct {
    /// A timestamp of when the fraudster registration job was created.
    created_at: ?i64,

    /// The IAM role Amazon Resource Name (ARN) that grants Voice ID permissions to
    /// access
    /// customer's buckets to read the input manifest file and write the job output
    /// file.
    data_access_role_arn: ?[]const u8,

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

    /// The input data config containing an S3 URI for the input manifest file that
    /// contains
    /// the list of fraudster registration job requests.
    input_data_config: ?InputDataConfig,

    /// The service-generated identifier for the fraudster registration job.
    job_id: ?[]const u8,

    /// The client-provided name for the fraudster registration job.
    job_name: ?[]const u8,

    /// Shows the completed percentage of registration requests listed in the input
    /// file.
    job_progress: ?JobProgress,

    /// The current status of the fraudster registration job.
    job_status: ?FraudsterRegistrationJobStatus,

    /// The output data config containing the S3 location where you want Voice ID to
    /// write
    /// your job output file; you must also include a KMS key ID in order to
    /// encrypt the file.
    output_data_config: ?OutputDataConfig,

    /// The registration config containing details such as the action to take when a
    /// duplicate
    /// fraudster is detected, and the similarity threshold to use for detecting a
    /// duplicate
    /// fraudster.
    registration_config: ?RegistrationConfig,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .data_access_role_arn = "DataAccessRoleArn",
        .domain_id = "DomainId",
        .ended_at = "EndedAt",
        .failure_details = "FailureDetails",
        .input_data_config = "InputDataConfig",
        .job_id = "JobId",
        .job_name = "JobName",
        .job_progress = "JobProgress",
        .job_status = "JobStatus",
        .output_data_config = "OutputDataConfig",
        .registration_config = "RegistrationConfig",
    };
};
