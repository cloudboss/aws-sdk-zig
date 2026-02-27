const aws = @import("aws");

const HyperParameterAlgorithmSpecification = @import("hyper_parameter_algorithm_specification.zig").HyperParameterAlgorithmSpecification;
const CheckpointConfig = @import("checkpoint_config.zig").CheckpointConfig;
const ParameterRanges = @import("parameter_ranges.zig").ParameterRanges;
const HyperParameterTuningResourceConfig = @import("hyper_parameter_tuning_resource_config.zig").HyperParameterTuningResourceConfig;
const Channel = @import("channel.zig").Channel;
const OutputDataConfig = @import("output_data_config.zig").OutputDataConfig;
const ResourceConfig = @import("resource_config.zig").ResourceConfig;
const RetryStrategy = @import("retry_strategy.zig").RetryStrategy;
const StoppingCondition = @import("stopping_condition.zig").StoppingCondition;
const HyperParameterTuningJobObjective = @import("hyper_parameter_tuning_job_objective.zig").HyperParameterTuningJobObjective;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// Defines the training jobs launched by a hyperparameter tuning job.
pub const HyperParameterTrainingJobDefinition = struct {
    /// The
    /// [HyperParameterAlgorithmSpecification](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_HyperParameterAlgorithmSpecification.html) object that specifies the resource algorithm to use for the training jobs that the tuning job launches.
    algorithm_specification: HyperParameterAlgorithmSpecification,

    checkpoint_config: ?CheckpointConfig,

    /// The job definition name.
    definition_name: ?[]const u8,

    /// To encrypt all communications between ML compute instances in distributed
    /// training, choose `True`. Encryption provides greater security for
    /// distributed training, but training might take longer. How long it takes
    /// depends on the amount of communication between compute instances, especially
    /// if you use a deep learning algorithm in distributed training.
    enable_inter_container_traffic_encryption: ?bool,

    /// A Boolean indicating whether managed spot training is enabled (`True`) or
    /// not (`False`).
    enable_managed_spot_training: ?bool,

    /// Isolates the training container. No inbound or outbound network calls can be
    /// made, except for calls between peers within a training cluster for
    /// distributed training. If network isolation is used for training jobs that
    /// are configured to use a VPC, SageMaker downloads and uploads customer data
    /// and model artifacts through the specified VPC, but the training container
    /// does not have network access.
    enable_network_isolation: ?bool,

    /// An environment variable that you can pass into the SageMaker
    /// [CreateTrainingJob](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateTrainingJob.html) API. You can use an existing [environment variable from the training container](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateTrainingJob.html#sagemaker-CreateTrainingJob-request-Environment) or use your own. See [Define metrics and variables](https://docs.aws.amazon.com/sagemaker/latest/dg/automatic-model-tuning-define-metrics-variables.html) for more information.
    ///
    /// The maximum number of items specified for `Map Entries` refers to the
    /// maximum number of environment variables for each `TrainingJobDefinition` and
    /// also the maximum for the hyperparameter tuning job itself. That is, the sum
    /// of the number of environment variables for all the training job definitions
    /// can't exceed the maximum number specified.
    environment: ?[]const aws.map.StringMapEntry,

    hyper_parameter_ranges: ?ParameterRanges,

    /// The configuration for the hyperparameter tuning resources, including the
    /// compute instances and storage volumes, used for training jobs launched by
    /// the tuning job. By default, storage volumes hold model artifacts and
    /// incremental states. Choose `File` for `TrainingInputMode` in the
    /// `AlgorithmSpecification` parameter to additionally store training data in
    /// the storage volume (optional).
    hyper_parameter_tuning_resource_config: ?HyperParameterTuningResourceConfig,

    /// An array of
    /// [Channel](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_Channel.html) objects that specify the input for the training jobs that the tuning job launches.
    input_data_config: ?[]const Channel,

    /// Specifies the path to the Amazon S3 bucket where you store model artifacts
    /// from the training jobs that the tuning job launches.
    output_data_config: OutputDataConfig,

    /// The resources, including the compute instances and storage volumes, to use
    /// for the training jobs that the tuning job launches.
    ///
    /// Storage volumes store model artifacts and incremental states. Training
    /// algorithms might also use storage volumes for scratch space. If you want
    /// SageMaker to use the storage volume to store the training data, choose
    /// `File` as the `TrainingInputMode` in the algorithm specification. For
    /// distributed training algorithms, specify an instance count greater than 1.
    ///
    /// If you want to use hyperparameter optimization with instance type
    /// flexibility, use `HyperParameterTuningResourceConfig` instead.
    resource_config: ?ResourceConfig,

    /// The number of times to retry the job when the job fails due to an
    /// `InternalServerError`.
    retry_strategy: ?RetryStrategy,

    /// The Amazon Resource Name (ARN) of the IAM role associated with the training
    /// jobs that the tuning job launches.
    role_arn: []const u8,

    /// Specifies the values of hyperparameters that do not change for the tuning
    /// job.
    static_hyper_parameters: ?[]const aws.map.StringMapEntry,

    /// Specifies a limit to how long a model hyperparameter training job can run.
    /// It also specifies how long a managed spot training job has to complete. When
    /// the job reaches the time limit, SageMaker ends the training job. Use this
    /// API to cap model training costs.
    stopping_condition: StoppingCondition,

    tuning_objective: ?HyperParameterTuningJobObjective,

    /// The
    /// [VpcConfig](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_VpcConfig.html) object that specifies the VPC that you want the training jobs that this hyperparameter tuning job launches to connect to. Control access to and from your training container by configuring the VPC. For more information, see [Protect Training Jobs by Using an Amazon Virtual Private Cloud](https://docs.aws.amazon.com/sagemaker/latest/dg/train-vpc.html).
    vpc_config: ?VpcConfig,

    pub const json_field_names = .{
        .algorithm_specification = "AlgorithmSpecification",
        .checkpoint_config = "CheckpointConfig",
        .definition_name = "DefinitionName",
        .enable_inter_container_traffic_encryption = "EnableInterContainerTrafficEncryption",
        .enable_managed_spot_training = "EnableManagedSpotTraining",
        .enable_network_isolation = "EnableNetworkIsolation",
        .environment = "Environment",
        .hyper_parameter_ranges = "HyperParameterRanges",
        .hyper_parameter_tuning_resource_config = "HyperParameterTuningResourceConfig",
        .input_data_config = "InputDataConfig",
        .output_data_config = "OutputDataConfig",
        .resource_config = "ResourceConfig",
        .retry_strategy = "RetryStrategy",
        .role_arn = "RoleArn",
        .static_hyper_parameters = "StaticHyperParameters",
        .stopping_condition = "StoppingCondition",
        .tuning_objective = "TuningObjective",
        .vpc_config = "VpcConfig",
    };
};
