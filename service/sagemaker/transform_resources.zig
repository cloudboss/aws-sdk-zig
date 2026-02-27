const TransformInstanceType = @import("transform_instance_type.zig").TransformInstanceType;

/// Describes the resources, including ML instance types and ML instance count,
/// to use for transform job.
pub const TransformResources = struct {
    /// The number of ML compute instances to use in the transform job. The default
    /// value is `1`, and the maximum is `100`. For distributed transform jobs,
    /// specify a value greater than `1`.
    instance_count: i32,

    /// The ML compute instance type for the transform job. If you are using
    /// built-in algorithms to transform moderately sized datasets, we recommend
    /// using ml.m4.xlarge or `ml.m5.large`instance types.
    instance_type: TransformInstanceType,

    /// Specifies an option from a collection of preconfigured Amazon Machine Image
    /// (AMI) images. Each image is configured by Amazon Web Services with a set of
    /// software and driver versions.
    ///
    /// **al2-ami-sagemaker-batch-gpu-470**
    ///
    /// * Accelerator: GPU
    /// * NVIDIA driver version: 470
    ///
    /// **al2-ami-sagemaker-batch-gpu-535**
    ///
    /// * Accelerator: GPU
    /// * NVIDIA driver version: 535
    transform_ami_version: ?[]const u8,

    /// The Amazon Web Services Key Management Service (Amazon Web Services KMS) key
    /// that Amazon SageMaker uses to encrypt model data on the storage volume
    /// attached to the ML compute instance(s) that run the batch transform job.
    ///
    /// Certain Nitro-based instances include local storage, dependent on the
    /// instance type. Local storage volumes are encrypted using a hardware module
    /// on the instance. You can't request a `VolumeKmsKeyId` when using an instance
    /// type with local storage.
    ///
    /// For a list of instance types that support local instance storage, see
    /// [Instance Store
    /// Volumes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html#instance-store-volumes).
    ///
    /// For more information about local instance storage encryption, see [SSD
    /// Instance Store
    /// Volumes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ssd-instance-store.html).
    ///
    /// The `VolumeKmsKeyId` can be any of the following formats:
    ///
    /// * Key ID: `1234abcd-12ab-34cd-56ef-1234567890ab`
    /// * Key ARN:
    ///   `arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab`
    /// * Alias name: `alias/ExampleAlias`
    /// * Alias name ARN: `arn:aws:kms:us-west-2:111122223333:alias/ExampleAlias`
    volume_kms_key_id: ?[]const u8,

    pub const json_field_names = .{
        .instance_count = "InstanceCount",
        .instance_type = "InstanceType",
        .transform_ami_version = "TransformAmiVersion",
        .volume_kms_key_id = "VolumeKmsKeyId",
    };
};
