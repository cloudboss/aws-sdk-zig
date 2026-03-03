const InputDataConfig = @import("input_data_config.zig").InputDataConfig;
const JobStatus = @import("job_status.zig").JobStatus;
const LanguageCode = @import("language_code.zig").LanguageCode;
const OutputDataConfig = @import("output_data_config.zig").OutputDataConfig;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// Provides information about a sentiment detection job.
pub const SentimentDetectionJobProperties = struct {
    /// The Amazon Resource Name (ARN) of the IAM role that
    /// grants Amazon Comprehend read access to your input data.
    data_access_role_arn: ?[]const u8 = null,

    /// The time that the sentiment detection job ended.
    end_time: ?i64 = null,

    /// The input data configuration that you supplied when you created the
    /// sentiment detection
    /// job.
    input_data_config: ?InputDataConfig = null,

    /// The Amazon Resource Name (ARN) of the sentiment detection job. It is a
    /// unique, fully
    /// qualified identifier for the job. It includes the Amazon Web Services
    /// account, Amazon Web Services Region, and the job ID. The
    /// format of the ARN is as follows:
    ///
    /// `arn::comprehend:::sentiment-detection-job/`
    ///
    /// The following is an example job ARN:
    ///
    /// `arn:aws:comprehend:us-west-2:111122223333:sentiment-detection-job/1234abcd12ab34cd56ef1234567890ab`
    job_arn: ?[]const u8 = null,

    /// The identifier assigned to the sentiment detection job.
    job_id: ?[]const u8 = null,

    /// The name that you assigned to the sentiment detection job
    job_name: ?[]const u8 = null,

    /// The current status of the sentiment detection job. If the status is
    /// `FAILED`,
    /// the `Messages` field shows the reason for the failure.
    job_status: ?JobStatus = null,

    /// The language code of the input documents.
    language_code: ?LanguageCode = null,

    /// A description of the status of a job.
    message: ?[]const u8 = null,

    /// The output data configuration that you supplied when you created the
    /// sentiment detection
    /// job.
    output_data_config: ?OutputDataConfig = null,

    /// The time that the sentiment detection job was submitted for processing.
    submit_time: ?i64 = null,

    /// ID for the Amazon Web Services Key Management Service (KMS) key that Amazon
    /// Comprehend uses to encrypt
    /// data on the storage volume attached to the ML compute instance(s) that
    /// process the analysis
    /// job. The VolumeKmsKeyId can be either of the following formats:
    ///
    /// * KMS Key ID: `"1234abcd-12ab-34cd-56ef-1234567890ab"`
    ///
    /// * Amazon Resource Name (ARN) of a KMS Key:
    /// `"arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"`
    volume_kms_key_id: ?[]const u8 = null,

    /// Configuration parameters for a private Virtual Private Cloud (VPC)
    /// containing the
    /// resources you are using for your sentiment detection job. For more
    /// information, see [Amazon
    /// VPC](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html).
    vpc_config: ?VpcConfig = null,

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
