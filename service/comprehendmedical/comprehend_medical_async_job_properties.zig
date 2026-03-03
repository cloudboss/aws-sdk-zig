const InputDataConfig = @import("input_data_config.zig").InputDataConfig;
const JobStatus = @import("job_status.zig").JobStatus;
const LanguageCode = @import("language_code.zig").LanguageCode;
const OutputDataConfig = @import("output_data_config.zig").OutputDataConfig;

/// Provides information about a detection job.
pub const ComprehendMedicalAsyncJobProperties = struct {
    /// The Amazon Resource Name (ARN) that gives Amazon Comprehend Medical read
    /// access to your input data.
    data_access_role_arn: ?[]const u8 = null,

    /// The time that the detection job completed.
    end_time: ?i64 = null,

    /// The date and time that job metadata is deleted from the server. Output files
    /// in your S3
    /// bucket will not be deleted. After the metadata is deleted, the job will no
    /// longer appear in
    /// the results of the `ListEntitiesDetectionV2Job` or the
    /// `ListPHIDetectionJobs` operation.
    expiration_time: ?i64 = null,

    /// The input data configuration that you supplied when you created the
    /// detection job.
    input_data_config: ?InputDataConfig = null,

    /// The identifier assigned to the detection job.
    job_id: ?[]const u8 = null,

    /// The name that you assigned to the detection job.
    job_name: ?[]const u8 = null,

    /// The current status of the detection job. If the status is `FAILED`, the
    /// `Message` field shows the reason for the failure.
    job_status: ?JobStatus = null,

    /// The AWS Key Management Service key, if any, used to encrypt the output
    /// files.
    kms_key: ?[]const u8 = null,

    /// The language code of the input documents.
    language_code: ?LanguageCode = null,

    /// The path to the file that describes the results of a batch job.
    manifest_file_path: ?[]const u8 = null,

    /// A description of the status of a job.
    message: ?[]const u8 = null,

    /// The version of the model used to analyze the documents. The version number
    /// looks like
    /// X.X.X. You can use this information to track the model used for a particular
    /// batch of
    /// documents.
    model_version: ?[]const u8 = null,

    /// The output data configuration that you supplied when you created the
    /// detection job.
    output_data_config: ?OutputDataConfig = null,

    /// The time that the detection job was submitted for processing.
    submit_time: ?i64 = null,

    pub const json_field_names = .{
        .data_access_role_arn = "DataAccessRoleArn",
        .end_time = "EndTime",
        .expiration_time = "ExpirationTime",
        .input_data_config = "InputDataConfig",
        .job_id = "JobId",
        .job_name = "JobName",
        .job_status = "JobStatus",
        .kms_key = "KMSKey",
        .language_code = "LanguageCode",
        .manifest_file_path = "ManifestFilePath",
        .message = "Message",
        .model_version = "ModelVersion",
        .output_data_config = "OutputDataConfig",
        .submit_time = "SubmitTime",
    };
};
