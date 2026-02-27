const InputDataConfig = @import("input_data_config.zig").InputDataConfig;
const JobStatus = @import("job_status.zig").JobStatus;
const OutputDataConfig = @import("output_data_config.zig").OutputDataConfig;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// Provides information about a document classification job.
pub const DocumentClassificationJobProperties = struct {
    /// The Amazon Resource Name (ARN) of the IAM role that
    /// grants Amazon Comprehend read access to your input data.
    data_access_role_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) that identifies the document classifier.
    document_classifier_arn: ?[]const u8,

    /// The time that the document classification job completed.
    end_time: ?i64,

    /// The Amazon Resource Number (ARN) of the flywheel
    flywheel_arn: ?[]const u8,

    /// The input data configuration that you supplied when you created the document
    /// classification job.
    input_data_config: ?InputDataConfig,

    /// The Amazon Resource Name (ARN) of the document classification job. It is a
    /// unique, fully
    /// qualified identifier for the job. It includes the Amazon Web Services
    /// account, Amazon Web Services Region, and the job ID. The
    /// format of the ARN is as follows:
    ///
    /// `arn::comprehend:::document-classification-job/`
    ///
    /// The following is an example job ARN:
    ///
    /// `arn:aws:comprehend:us-west-2:111122223333:document-classification-job/1234abcd12ab34cd56ef1234567890ab`
    job_arn: ?[]const u8,

    /// The identifier assigned to the document classification job.
    job_id: ?[]const u8,

    /// The name that you assigned to the document classification job.
    job_name: ?[]const u8,

    /// The current status of the document classification job. If the status is
    /// `FAILED`, the `Message` field shows the reason for the failure.
    job_status: ?JobStatus,

    /// A description of the status of the job.
    message: ?[]const u8,

    /// The output data configuration that you supplied when you created the
    /// document
    /// classification job.
    output_data_config: ?OutputDataConfig,

    /// The time that the document classification job was submitted for processing.
    submit_time: ?i64,

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
    volume_kms_key_id: ?[]const u8,

    /// Configuration parameters for a private Virtual Private Cloud (VPC)
    /// containing the
    /// resources you are using for your document classification job. For more
    /// information, see [Amazon
    /// VPC](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html).
    vpc_config: ?VpcConfig,

    pub const json_field_names = .{
        .data_access_role_arn = "DataAccessRoleArn",
        .document_classifier_arn = "DocumentClassifierArn",
        .end_time = "EndTime",
        .flywheel_arn = "FlywheelArn",
        .input_data_config = "InputDataConfig",
        .job_arn = "JobArn",
        .job_id = "JobId",
        .job_name = "JobName",
        .job_status = "JobStatus",
        .message = "Message",
        .output_data_config = "OutputDataConfig",
        .submit_time = "SubmitTime",
        .volume_kms_key_id = "VolumeKmsKeyId",
        .vpc_config = "VpcConfig",
    };
};
