const InstanceGroup = @import("instance_group.zig").InstanceGroup;
const InstancePlacementConfig = @import("instance_placement_config.zig").InstancePlacementConfig;
const TrainingInstanceType = @import("training_instance_type.zig").TrainingInstanceType;

/// Describes the resources, including machine learning (ML) compute instances
/// and ML storage volumes, to use for model training.
pub const ResourceConfig = struct {
    /// The number of ML compute instances to use. For distributed training, provide
    /// a value greater than 1.
    instance_count: ?i32,

    /// The configuration of a heterogeneous cluster in JSON format.
    instance_groups: ?[]const InstanceGroup,

    /// Configuration for how training job instances are placed and allocated within
    /// UltraServers. Only applicable for UltraServer capacity.
    instance_placement_config: ?InstancePlacementConfig,

    /// The ML compute instance type.
    instance_type: ?TrainingInstanceType,

    /// The duration of time in seconds to retain configured resources in a warm
    /// pool for subsequent training jobs.
    keep_alive_period_in_seconds: ?i32,

    /// The Amazon Resource Name (ARN); of the training plan to use for this
    /// resource configuration.
    training_plan_arn: ?[]const u8,

    /// The Amazon Web Services KMS key that SageMaker uses to encrypt data on the
    /// storage volume attached to the ML compute instance(s) that run the training
    /// job.
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
    /// The `VolumeKmsKeyId` can be in any of the following formats:
    ///
    /// * // KMS Key ID
    ///
    /// `"1234abcd-12ab-34cd-56ef-1234567890ab"`
    /// * // Amazon Resource Name (ARN) of a KMS Key
    ///
    /// `"arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"`
    volume_kms_key_id: ?[]const u8,

    /// The size of the ML storage volume that you want to provision.
    ///
    /// SageMaker automatically selects the volume size for serverless training
    /// jobs. You cannot customize this setting.
    ///
    /// ML storage volumes store model artifacts and incremental states. Training
    /// algorithms might also use the ML storage volume for scratch space. If you
    /// want to store the training data in the ML storage volume, choose `File` as
    /// the `TrainingInputMode` in the algorithm specification.
    ///
    /// When using an ML instance with [NVMe SSD
    /// volumes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ssd-instance-store.html#nvme-ssd-volumes), SageMaker doesn't provision Amazon EBS General Purpose SSD (gp2) storage. Available storage is fixed to the NVMe-type instance's storage capacity. SageMaker configures storage paths for training datasets, checkpoints, model artifacts, and outputs to use the entire capacity of the instance storage. For example, ML instance families with the NVMe-type instance storage include `ml.p4d`, `ml.g4dn`, and `ml.g5`.
    ///
    /// When using an ML instance with the EBS-only storage option and without
    /// instance storage, you must define the size of EBS volume through
    /// `VolumeSizeInGB` in the `ResourceConfig` API. For example, ML instance
    /// families that use EBS volumes include `ml.c5` and `ml.p2`.
    ///
    /// To look up instance types and their instance storage types and volumes, see
    /// [Amazon EC2 Instance Types](http://aws.amazon.com/ec2/instance-types/).
    ///
    /// To find the default local paths defined by the SageMaker training platform,
    /// see [Amazon SageMaker Training Storage Folders for Training Datasets,
    /// Checkpoints, Model Artifacts, and
    /// Outputs](https://docs.aws.amazon.com/sagemaker/latest/dg/model-train-storage.html).
    volume_size_in_gb: ?i32,

    pub const json_field_names = .{
        .instance_count = "InstanceCount",
        .instance_groups = "InstanceGroups",
        .instance_placement_config = "InstancePlacementConfig",
        .instance_type = "InstanceType",
        .keep_alive_period_in_seconds = "KeepAlivePeriodInSeconds",
        .training_plan_arn = "TrainingPlanArn",
        .volume_kms_key_id = "VolumeKmsKeyId",
        .volume_size_in_gb = "VolumeSizeInGB",
    };
};
