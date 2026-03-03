/// Output configuration information for a labeling job.
pub const LabelingJobOutputConfig = struct {
    /// The Amazon Web Services Key Management Service ID of the key used to encrypt
    /// the output data, if any.
    ///
    /// If you provide your own KMS key ID, you must add the required permissions to
    /// your KMS key described in [Encrypt Output Data and Storage Volume with
    /// Amazon Web Services
    /// KMS](https://docs.aws.amazon.com/sagemaker/latest/dg/sms-security-permission.html#sms-security-kms-permissions).
    ///
    /// If you don't provide a KMS key ID, Amazon SageMaker uses the default Amazon
    /// Web Services KMS key for Amazon S3 for your role's account to encrypt your
    /// output data.
    ///
    /// If you use a bucket policy with an `s3:PutObject` permission that only
    /// allows objects with server-side encryption, set the condition key of
    /// `s3:x-amz-server-side-encryption` to `"aws:kms"`. For more information, see
    /// [KMS-Managed Encryption
    /// Keys](https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingKMSEncryption.html) in the *Amazon Simple Storage Service Developer Guide.*
    kms_key_id: ?[]const u8 = null,

    /// The Amazon S3 location to write output data.
    s3_output_path: []const u8,

    /// An Amazon Simple Notification Service (Amazon SNS) output topic ARN. Provide
    /// a `SnsTopicArn` if you want to do real time chaining to another streaming
    /// job and receive an Amazon SNS notifications each time a data object is
    /// submitted by a worker.
    ///
    /// If you provide an `SnsTopicArn` in `OutputConfig`, when workers complete
    /// labeling tasks, Ground Truth will send labeling task output data to the SNS
    /// output topic you specify here.
    ///
    /// To learn more, see [Receive Output Data from a Streaming Labeling
    /// Job](https://docs.aws.amazon.com/sagemaker/latest/dg/sms-streaming-labeling-job.html#sms-streaming-how-it-works-output-data).
    sns_topic_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .kms_key_id = "KmsKeyId",
        .s3_output_path = "S3OutputPath",
        .sns_topic_arn = "SnsTopicArn",
    };
};
