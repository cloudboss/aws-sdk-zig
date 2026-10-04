const ProcessingInstancePreference = @import("processing_instance_preference.zig").ProcessingInstancePreference;
const ProcessingInstanceType = @import("processing_instance_type.zig").ProcessingInstanceType;

/// Configuration for the cluster used to run a processing job.
pub const ProcessingClusterConfig = struct {
    /// The number of ML compute instances to use in the processing job. For
    /// distributed processing jobs, specify a value greater than 1. The default
    /// value is 1.
    instance_count: ?i32 = null,

    /// An ordered list of ML compute instance types for the processing job, in
    /// priority order. Amazon SageMaker launches the job on the first instance type
    /// in the list that has available capacity. If capacity is insufficient, Amazon
    /// SageMaker evaluates the next instance type in the list. Exactly one instance
    /// type is selected for the job.
    ///
    /// `InstancePreferences` is mutually exclusive with `InstanceType`.
    instance_preferences: ?[]const ProcessingInstancePreference = null,

    /// The ML compute instance type for the processing job.
    instance_type: ?ProcessingInstanceType = null,

    /// The number of instances of `SelectedInstanceType` that the job launched
    /// with. The job is billed for this instance type and count. Returned by
    /// `DescribeProcessingJob` after an instance type is selected. This field is
    /// read-only and isn't accepted in `CreateProcessingJob` requests.
    selected_instance_count: ?i32 = null,

    /// The instance type that Amazon SageMaker selected for the job from
    /// `InstancePreferences`. Returned by `
    /// [DescribeProcessingJob](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DescribeProcessingJob.html) ` after an instance type is selected. This field is read-only and isn't accepted in `CreateProcessingJob` requests.
    selected_instance_type: ?ProcessingInstanceType = null,

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
        .instance_preferences = "InstancePreferences",
        .instance_type = "InstanceType",
        .selected_instance_count = "SelectedInstanceCount",
        .selected_instance_type = "SelectedInstanceType",
        .volume_kms_key_id = "VolumeKmsKeyId",
        .volume_size_in_gb = "VolumeSizeInGB",
    };
};
