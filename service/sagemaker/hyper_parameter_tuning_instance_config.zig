const TrainingInstanceType = @import("training_instance_type.zig").TrainingInstanceType;

/// The configuration for hyperparameter tuning resources for use in training
/// jobs launched by the tuning job. These resources include compute instances
/// and storage volumes. Specify one or more compute instance configurations and
/// allocation strategies to select resources (optional).
pub const HyperParameterTuningInstanceConfig = struct {
    /// The number of instances of the type specified by `InstanceType`. Choose an
    /// instance count larger than 1 for distributed training algorithms. See [Step
    /// 2: Launch a SageMaker Distributed Training Job Using the SageMaker Python
    /// SDK](https://docs.aws.amazon.com/sagemaker/latest/dg/data-parallel-use-api.html) for more information.
    instance_count: i32,

    /// The instance type used for processing of hyperparameter optimization jobs.
    /// Choose from general purpose (no GPUs) instance types: ml.m5.xlarge,
    /// ml.m5.2xlarge, and ml.m5.4xlarge or compute optimized (no GPUs) instance
    /// types: ml.c5.xlarge and ml.c5.2xlarge. For more information about instance
    /// types, see [instance type
    /// descriptions](https://docs.aws.amazon.com/sagemaker/latest/dg/notebooks-available-instance-types.html).
    instance_type: TrainingInstanceType,

    /// The volume size in GB of the data to be processed for hyperparameter
    /// optimization (optional).
    volume_size_in_gb: i32,

    pub const json_field_names = .{
        .instance_count = "InstanceCount",
        .instance_type = "InstanceType",
        .volume_size_in_gb = "VolumeSizeInGB",
    };
};
