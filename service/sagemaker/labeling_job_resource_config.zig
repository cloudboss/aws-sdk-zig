const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// Configure encryption on the storage volume attached to the ML compute
/// instance used to run automated data labeling model training and inference.
pub const LabelingJobResourceConfig = struct {
    /// The Amazon Web Services Key Management Service (Amazon Web Services KMS) key
    /// that Amazon SageMaker uses to encrypt data on the storage volume attached to
    /// the ML compute instance(s) that run the training and inference jobs used for
    /// automated data labeling.
    ///
    /// You can only specify a `VolumeKmsKeyId` when you create a labeling job with
    /// automated data labeling enabled using the API operation `CreateLabelingJob`.
    /// You cannot specify an Amazon Web Services KMS key to encrypt the storage
    /// volume used for automated data labeling model training and inference when
    /// you create a labeling job using the console. To learn more, see [Output Data
    /// and Storage Volume
    /// Encryption](https://docs.aws.amazon.com/sagemaker/latest/dg/sms-security.html).
    ///
    /// The `VolumeKmsKeyId` can be any of the following formats:
    ///
    /// * KMS Key ID
    ///
    /// `"1234abcd-12ab-34cd-56ef-1234567890ab"`
    /// * Amazon Resource Name (ARN) of a KMS Key
    ///
    /// `"arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"`
    volume_kms_key_id: ?[]const u8,

    vpc_config: ?VpcConfig,

    pub const json_field_names = .{
        .volume_kms_key_id = "VolumeKmsKeyId",
        .vpc_config = "VpcConfig",
    };
};
