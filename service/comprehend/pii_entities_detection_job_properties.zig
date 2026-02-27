const InputDataConfig = @import("input_data_config.zig").InputDataConfig;
const JobStatus = @import("job_status.zig").JobStatus;
const LanguageCode = @import("language_code.zig").LanguageCode;
const PiiEntitiesDetectionMode = @import("pii_entities_detection_mode.zig").PiiEntitiesDetectionMode;
const PiiOutputDataConfig = @import("pii_output_data_config.zig").PiiOutputDataConfig;
const RedactionConfig = @import("redaction_config.zig").RedactionConfig;

/// Provides information about a PII entities detection job.
pub const PiiEntitiesDetectionJobProperties = struct {
    /// The Amazon Resource Name (ARN) of the IAM role that
    /// grants Amazon Comprehend read access to your input data.
    data_access_role_arn: ?[]const u8,

    /// The time that the PII entities detection job completed.
    end_time: ?i64,

    /// The input properties for a PII entities detection job.
    input_data_config: ?InputDataConfig,

    /// The Amazon Resource Name (ARN) of the PII entities detection job. It is a
    /// unique, fully
    /// qualified identifier for the job. It includes the Amazon Web Services
    /// account, Amazon Web Services Region, and the job ID. The
    /// format of the ARN is as follows:
    ///
    /// `arn::comprehend:::pii-entities-detection-job/`
    ///
    /// The following is an example job ARN:
    ///
    /// `arn:aws:comprehend:us-west-2:111122223333:pii-entities-detection-job/1234abcd12ab34cd56ef1234567890ab`
    job_arn: ?[]const u8,

    /// The identifier assigned to the PII entities detection job.
    job_id: ?[]const u8,

    /// The name that you assigned the PII entities detection job.
    job_name: ?[]const u8,

    /// The current status of the PII entities detection job. If the status is
    /// `FAILED`, the `Message` field shows the reason for the failure.
    job_status: ?JobStatus,

    /// The language code of the input documents.
    language_code: ?LanguageCode,

    /// A description of the status of a job.
    message: ?[]const u8,

    /// Specifies whether the output provides the locations (offsets) of PII
    /// entities or a file in
    /// which PII entities are redacted.
    mode: ?PiiEntitiesDetectionMode,

    /// The output data configuration that you supplied when you created the PII
    /// entities
    /// detection job.
    output_data_config: ?PiiOutputDataConfig,

    /// Provides configuration parameters for PII entity redaction.
    ///
    /// This parameter is required if you set the `Mode` parameter to
    /// `ONLY_REDACTION`. In that case, you must provide a `RedactionConfig`
    /// definition that includes the `PiiEntityTypes` parameter.
    redaction_config: ?RedactionConfig,

    /// The time that the PII entities detection job was submitted for processing.
    submit_time: ?i64,

    pub const json_field_names = .{
        .data_access_role_arn = "DataAccessRoleArn",
        .end_time = "EndTime",
        .input_data_config = "InputDataConfig",
        .job_arn = "JobArn",
        .job_id = "JobId",
        .job_name = "JobName",
        .job_status = "JobStatus",
        .language_code = "LanguageCode",
        .message = "Message",
        .mode = "Mode",
        .output_data_config = "OutputDataConfig",
        .redaction_config = "RedactionConfig",
        .submit_time = "SubmitTime",
    };
};
