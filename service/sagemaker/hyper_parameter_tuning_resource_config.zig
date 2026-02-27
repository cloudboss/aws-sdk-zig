const HyperParameterTuningAllocationStrategy = @import("hyper_parameter_tuning_allocation_strategy.zig").HyperParameterTuningAllocationStrategy;
const HyperParameterTuningInstanceConfig = @import("hyper_parameter_tuning_instance_config.zig").HyperParameterTuningInstanceConfig;
const TrainingInstanceType = @import("training_instance_type.zig").TrainingInstanceType;

/// The configuration of resources, including compute instances and storage
/// volumes for use in training jobs launched by hyperparameter tuning jobs.
/// `HyperParameterTuningResourceConfig` is similar to `ResourceConfig`, but has
/// the additional `InstanceConfigs` and `AllocationStrategy` fields to allow
/// for flexible instance management. Specify one or more instance types, count,
/// and the allocation strategy for instance selection.
///
/// `HyperParameterTuningResourceConfig` supports the capabilities of
/// `ResourceConfig` with the exception of `KeepAlivePeriodInSeconds`.
/// Hyperparameter tuning jobs use warm pools by default, which reuse clusters
/// between training jobs.
pub const HyperParameterTuningResourceConfig = struct {
    /// The strategy that determines the order of preference for resources specified
    /// in `InstanceConfigs` used in hyperparameter optimization.
    allocation_strategy: ?HyperParameterTuningAllocationStrategy,

    /// A list containing the configuration(s) for one or more resources for
    /// processing hyperparameter jobs. These resources include compute instances
    /// and storage volumes to use in model training jobs launched by hyperparameter
    /// tuning jobs. The `AllocationStrategy` controls the order in which multiple
    /// configurations provided in `InstanceConfigs` are used.
    ///
    /// If you only want to use a single instance configuration inside the
    /// `HyperParameterTuningResourceConfig` API, do not provide a value for
    /// `InstanceConfigs`. Instead, use `InstanceType`, `VolumeSizeInGB` and
    /// `InstanceCount`. If you use `InstanceConfigs`, do not provide values for
    /// `InstanceType`, `VolumeSizeInGB` or `InstanceCount`.
    instance_configs: ?[]const HyperParameterTuningInstanceConfig,

    /// The number of compute instances of type `InstanceType` to use. For
    /// [distributed
    /// training](https://docs.aws.amazon.com/sagemaker/latest/dg/data-parallel-use-api.html), select a value greater than 1.
    instance_count: ?i32,

    /// The instance type used to run hyperparameter optimization tuning jobs. See [
    /// descriptions of instance
    /// types](https://docs.aws.amazon.com/sagemaker/latest/dg/notebooks-available-instance-types.html) for more information.
    instance_type: ?TrainingInstanceType,

    /// A key used by Amazon Web Services Key Management Service to encrypt data on
    /// the storage volume attached to the compute instances used to run the
    /// training job. You can use either of the following formats to specify a key.
    ///
    /// KMS Key ID:
    ///
    /// `"1234abcd-12ab-34cd-56ef-1234567890ab"`
    ///
    /// Amazon Resource Name (ARN) of a KMS key:
    ///
    /// `"arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"`
    ///
    /// Some instances use local storage, which use a [hardware module to
    /// encrypt](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ssd-instance-store.html) storage volumes. If you choose one of these instance types, you cannot request a `VolumeKmsKeyId`. For a list of instance types that use local storage, see [instance store volumes](http://aws.amazon.com/releasenotes/host-instance-storage-volumes-table/). For more information about Amazon Web Services Key Management Service, see [KMS encryption](https://docs.aws.amazon.com/sagemaker/latest/dg/sms-security-kms-permissions.html) for more information.
    volume_kms_key_id: ?[]const u8,

    /// The volume size in GB for the storage volume to be used in processing
    /// hyperparameter optimization jobs (optional). These volumes store model
    /// artifacts, incremental states and optionally, scratch space for training
    /// algorithms. Do not provide a value for this parameter if a value for
    /// `InstanceConfigs` is also specified.
    ///
    /// Some instance types have a fixed total local storage size. If you select one
    /// of these instances for training, `VolumeSizeInGB` cannot be greater than
    /// this total size. For a list of instance types with local instance storage
    /// and their sizes, see [instance store
    /// volumes](http://aws.amazon.com/releasenotes/host-instance-storage-volumes-table/).
    ///
    /// SageMaker supports only the [General Purpose SSD
    /// (gp2)](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-volume-types.html) storage volume type.
    volume_size_in_gb: ?i32,

    pub const json_field_names = .{
        .allocation_strategy = "AllocationStrategy",
        .instance_configs = "InstanceConfigs",
        .instance_count = "InstanceCount",
        .instance_type = "InstanceType",
        .volume_kms_key_id = "VolumeKmsKeyId",
        .volume_size_in_gb = "VolumeSizeInGB",
    };
};
