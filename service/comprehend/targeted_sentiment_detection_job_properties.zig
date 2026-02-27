const InputDataConfig = @import("input_data_config.zig").InputDataConfig;
const JobStatus = @import("job_status.zig").JobStatus;
const LanguageCode = @import("language_code.zig").LanguageCode;
const OutputDataConfig = @import("output_data_config.zig").OutputDataConfig;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// Provides information about a targeted sentiment detection job.
pub const TargetedSentimentDetectionJobProperties = struct {
    /// The Amazon Resource Name (ARN) of the IAM role that
    /// grants Amazon Comprehend read access to your input data.
    data_access_role_arn: ?[]const u8,

    /// The time that the targeted sentiment detection job ended.
    end_time: ?i64,

    input_data_config: ?InputDataConfig,

    /// The Amazon Resource Name (ARN) of the targeted sentiment detection job. It
    /// is a unique, fully
    /// qualified identifier for the job. It includes the Amazon Web Services
    /// account, Amazon Web Services Region, and the job ID. The
    /// format of the ARN is as follows:
    ///
    /// `arn::comprehend:::targeted-sentiment-detection-job/`
    ///
    /// The following is an example job ARN:
    ///
    /// `arn:aws:comprehend:us-west-2:111122223333:targeted-sentiment-detection-job/1234abcd12ab34cd56ef1234567890ab`
    job_arn: ?[]const u8,

    /// The identifier assigned to the targeted sentiment detection job.
    job_id: ?[]const u8,

    /// The name that you assigned to the targeted sentiment detection job.
    job_name: ?[]const u8,

    /// The current status of the targeted sentiment detection job. If the status is
    /// `FAILED`,
    /// the `Messages` field shows the reason for the failure.
    job_status: ?JobStatus,

    /// The language code of the input documents.
    language_code: ?LanguageCode,

    /// A description of the status of a job.
    message: ?[]const u8,

    output_data_config: ?OutputDataConfig,

    /// The time that the targeted sentiment detection job was submitted for
    /// processing.
    submit_time: ?i64,

    /// ID for the KMS key that Amazon Comprehend uses to encrypt the
    /// data on the storage volume attached to the ML compute instance(s) that
    /// process the
    /// targeted sentiment detection job. The VolumeKmsKeyId can be either of the
    /// following formats:
    ///
    /// * KMS Key ID: `"1234abcd-12ab-34cd-56ef-1234567890ab"`
    ///
    /// * Amazon Resource Name (ARN) of a KMS Key:
    /// `"arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"`
    volume_kms_key_id: ?[]const u8,

    vpc_config: ?VpcConfig,

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
        .output_data_config = "OutputDataConfig",
        .submit_time = "SubmitTime",
        .volume_kms_key_id = "VolumeKmsKeyId",
        .vpc_config = "VpcConfig",
    };
};
