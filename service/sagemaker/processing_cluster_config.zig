const ProcessingInstanceType = @import("processing_instance_type.zig").ProcessingInstanceType;

/// Configuration for the cluster used to run a processing job.
pub const ProcessingClusterConfig = struct {
    /// The number of ML compute instances to use in the processing job. For
    /// distributed processing jobs, specify a value greater than 1. The default
    /// value is 1.
    instance_count: i32,

    /// The ML compute instance type for the processing job.
    instance_type: ProcessingInstanceType,

    /// The Amazon Web Services Key Management Service (Amazon Web Services KMS) key
    /// that Amazon SageMaker uses to encrypt data on the storage volume attached to
    /// the ML compute instance(s) that run the processing job.
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
    volume_kms_key_id: ?[]const u8 = null,

    /// The size of the ML storage volume in gigabytes that you want to provision.
    /// You must specify sufficient ML storage for your scenario.
    ///
    /// Certain Nitro-based instances include local storage with a fixed total size,
    /// dependent on the instance type. When using these instances for processing,
    /// Amazon SageMaker mounts the local instance storage instead of Amazon EBS gp2
    /// storage. You can't request a `VolumeSizeInGB` greater than the total size of
    /// the local instance storage.
    ///
    /// For a list of instance types that support local instance storage, including
    /// the total size per instance type, see [Instance Store
    /// Volumes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html#instance-store-volumes).
    volume_size_in_gb: i32,

    pub const json_field_names = .{
        .instance_count = "InstanceCount",
        .instance_type = "InstanceType",
        .volume_kms_key_id = "VolumeKmsKeyId",
        .volume_size_in_gb = "VolumeSizeInGB",
    };
};
