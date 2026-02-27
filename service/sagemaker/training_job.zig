const aws = @import("aws");

const AlgorithmSpecification = @import("algorithm_specification.zig").AlgorithmSpecification;
const CheckpointConfig = @import("checkpoint_config.zig").CheckpointConfig;
const DebugHookConfig = @import("debug_hook_config.zig").DebugHookConfig;
const DebugRuleConfiguration = @import("debug_rule_configuration.zig").DebugRuleConfiguration;
const DebugRuleEvaluationStatus = @import("debug_rule_evaluation_status.zig").DebugRuleEvaluationStatus;
const ExperimentConfig = @import("experiment_config.zig").ExperimentConfig;
const MetricData = @import("metric_data.zig").MetricData;
const Channel = @import("channel.zig").Channel;
const ModelArtifacts = @import("model_artifacts.zig").ModelArtifacts;
const ModelPackageConfig = @import("model_package_config.zig").ModelPackageConfig;
const OutputDataConfig = @import("output_data_config.zig").OutputDataConfig;
const ProfilerConfig = @import("profiler_config.zig").ProfilerConfig;
const ResourceConfig = @import("resource_config.zig").ResourceConfig;
const RetryStrategy = @import("retry_strategy.zig").RetryStrategy;
const SecondaryStatus = @import("secondary_status.zig").SecondaryStatus;
const SecondaryStatusTransition = @import("secondary_status_transition.zig").SecondaryStatusTransition;
const StoppingCondition = @import("stopping_condition.zig").StoppingCondition;
const Tag = @import("tag.zig").Tag;
const TensorBoardOutputConfig = @import("tensor_board_output_config.zig").TensorBoardOutputConfig;
const TrainingJobStatus = @import("training_job_status.zig").TrainingJobStatus;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// Contains information about a training job.
pub const TrainingJob = struct {
    /// Information about the algorithm used for training, and algorithm metadata.
    algorithm_specification: ?AlgorithmSpecification,

    /// The Amazon Resource Name (ARN) of the job.
    auto_ml_job_arn: ?[]const u8,

    /// The billable time in seconds.
    billable_time_in_seconds: ?i32,

    checkpoint_config: ?CheckpointConfig,

    /// A timestamp that indicates when the training job was created.
    creation_time: ?i64,

    debug_hook_config: ?DebugHookConfig,

    /// Information about the debug rule configuration.
    debug_rule_configurations: ?[]const DebugRuleConfiguration,

    /// Information about the evaluation status of the rules for the training job.
    debug_rule_evaluation_statuses: ?[]const DebugRuleEvaluationStatus,

    /// To encrypt all communications between ML compute instances in distributed
    /// training, choose `True`. Encryption provides greater security for
    /// distributed training, but training might take longer. How long it takes
    /// depends on the amount of communication between compute instances, especially
    /// if you use a deep learning algorithm in distributed training.
    enable_inter_container_traffic_encryption: ?bool,

    /// When true, enables managed spot training using Amazon EC2 Spot instances to
    /// run training jobs instead of on-demand instances. For more information, see
    /// [Managed Spot
    /// Training](https://docs.aws.amazon.com/sagemaker/latest/dg/model-managed-spot-training.html).
    enable_managed_spot_training: ?bool,

    /// If the `TrainingJob` was created with network isolation, the value is set to
    /// `true`. If network isolation is enabled, nodes can't communicate beyond the
    /// VPC they run in.
    enable_network_isolation: ?bool,

    /// The environment variables to set in the Docker container.
    environment: ?[]const aws.map.StringMapEntry,

    experiment_config: ?ExperimentConfig,

    /// If the training job failed, the reason it failed.
    failure_reason: ?[]const u8,

    /// A list of final metric values that are set when the training job completes.
    /// Used only if the training job was configured to use metrics.
    final_metric_data_list: ?[]const MetricData,

    /// Algorithm-specific parameters.
    hyper_parameters: ?[]const aws.map.StringMapEntry,

    /// An array of `Channel` objects that describes each data input channel.
    ///
    /// Your input must be in the same Amazon Web Services region as your training
    /// job.
    input_data_config: ?[]const Channel,

    /// The Amazon Resource Name (ARN) of the labeling job.
    labeling_job_arn: ?[]const u8,

    /// A timestamp that indicates when the status of the training job was last
    /// modified.
    last_modified_time: ?i64,

    /// Information about the Amazon S3 location that is configured for storing
    /// model artifacts.
    model_artifacts: ?ModelArtifacts,

    /// The model package configuration.
    model_package_config: ?ModelPackageConfig,

    /// The S3 path where model artifacts that you configured when creating the job
    /// are stored. SageMaker creates subfolders for model artifacts.
    output_data_config: ?OutputDataConfig,

    /// The output model package Amazon Resource Name (ARN) that contains model
    /// weights or checkpoint.
    output_model_package_arn: ?[]const u8,

    profiler_config: ?ProfilerConfig,

    /// Resources, including ML compute instances and ML storage volumes, that are
    /// configured for model training.
    resource_config: ?ResourceConfig,

    /// The number of times to retry the job when the job fails due to an
    /// `InternalServerError`.
    retry_strategy: ?RetryStrategy,

    /// The Amazon Web Services Identity and Access Management (IAM) role configured
    /// for the training job.
    role_arn: ?[]const u8,

    /// Provides detailed information about the state of the training job. For
    /// detailed information about the secondary status of the training job, see
    /// `StatusMessage` under
    /// [SecondaryStatusTransition](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_SecondaryStatusTransition.html).
    ///
    /// SageMaker provides primary statuses and secondary statuses that apply to
    /// each of them:
    ///
    /// **InProgress**
    ///
    /// * `Starting` - Starting the training job.
    /// * `Downloading` - An optional stage for algorithms that support `File`
    ///   training input mode. It indicates that data is being downloaded to the ML
    ///   storage volumes.
    /// * `Training` - Training is in progress.
    /// * `Uploading` - Training is complete and the model artifacts are being
    ///   uploaded to the S3 location.
    ///
    /// **Completed**
    ///
    /// * `Completed` - The training job has completed.
    ///
    /// **Failed**
    ///
    /// * `Failed` - The training job has failed. The reason for the failure is
    ///   returned in the `FailureReason` field of `DescribeTrainingJobResponse`.
    ///
    /// **Stopped**
    ///
    /// * `MaxRuntimeExceeded` - The job stopped because it exceeded the maximum
    ///   allowed runtime.
    /// * `Stopped` - The training job has stopped.
    ///
    /// **Stopping**
    ///
    /// * `Stopping` - Stopping the training job.
    ///
    /// Valid values for `SecondaryStatus` are subject to change.
    ///
    /// We no longer support the following secondary statuses:
    ///
    /// * `LaunchingMLInstances`
    /// * `PreparingTrainingStack`
    /// * `DownloadingTrainingImage`
    secondary_status: ?SecondaryStatus,

    /// A history of all of the secondary statuses that the training job has
    /// transitioned through.
    secondary_status_transitions: ?[]const SecondaryStatusTransition,

    /// Specifies a limit to how long a model training job can run. It also
    /// specifies how long a managed Spot training job has to complete. When the job
    /// reaches the time limit, SageMaker ends the training job. Use this API to cap
    /// model training costs.
    ///
    /// To stop a job, SageMaker sends the algorithm the `SIGTERM` signal, which
    /// delays job termination for 120 seconds. Algorithms can use this 120-second
    /// window to save the model artifacts, so the results of training are not lost.
    stopping_condition: ?StoppingCondition,

    /// An array of key-value pairs. You can use tags to categorize your Amazon Web
    /// Services resources in different ways, for example, by purpose, owner, or
    /// environment. For more information, see [Tagging Amazon Web Services
    /// Resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html).
    tags: ?[]const Tag,

    tensor_board_output_config: ?TensorBoardOutputConfig,

    /// Indicates the time when the training job ends on training instances. You are
    /// billed for the time interval between the value of `TrainingStartTime` and
    /// this time. For successful jobs and stopped jobs, this is the time after
    /// model artifacts are uploaded. For failed jobs, this is the time when
    /// SageMaker detects a job failure.
    training_end_time: ?i64,

    /// The Amazon Resource Name (ARN) of the training job.
    training_job_arn: ?[]const u8,

    /// The name of the training job.
    training_job_name: ?[]const u8,

    /// The status of the training job.
    ///
    /// Training job statuses are:
    ///
    /// * `InProgress` - The training is in progress.
    /// * `Completed` - The training job has completed.
    /// * `Failed` - The training job has failed. To see the reason for the failure,
    ///   see the `FailureReason` field in the response to a
    ///   `DescribeTrainingJobResponse` call.
    /// * `Stopping` - The training job is stopping.
    /// * `Stopped` - The training job has stopped.
    ///
    /// For more detailed information, see `SecondaryStatus`.
    training_job_status: ?TrainingJobStatus,

    /// Indicates the time when the training job starts on training instances. You
    /// are billed for the time interval between this time and the value of
    /// `TrainingEndTime`. The start time in CloudWatch Logs might be later than
    /// this time. The difference is due to the time it takes to download the
    /// training data and to the size of the training container.
    training_start_time: ?i64,

    /// The training time in seconds.
    training_time_in_seconds: ?i32,

    /// The Amazon Resource Name (ARN) of the associated hyperparameter tuning job
    /// if the training job was launched by a hyperparameter tuning job.
    tuning_job_arn: ?[]const u8,

    /// A
    /// [VpcConfig](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_VpcConfig.html) object that specifies the VPC that this training job has access to. For more information, see [Protect Training Jobs by Using an Amazon Virtual Private Cloud](https://docs.aws.amazon.com/sagemaker/latest/dg/train-vpc.html).
    vpc_config: ?VpcConfig,

    pub const json_field_names = .{
        .algorithm_specification = "AlgorithmSpecification",
        .auto_ml_job_arn = "AutoMLJobArn",
        .billable_time_in_seconds = "BillableTimeInSeconds",
        .checkpoint_config = "CheckpointConfig",
        .creation_time = "CreationTime",
        .debug_hook_config = "DebugHookConfig",
        .debug_rule_configurations = "DebugRuleConfigurations",
        .debug_rule_evaluation_statuses = "DebugRuleEvaluationStatuses",
        .enable_inter_container_traffic_encryption = "EnableInterContainerTrafficEncryption",
        .enable_managed_spot_training = "EnableManagedSpotTraining",
        .enable_network_isolation = "EnableNetworkIsolation",
        .environment = "Environment",
        .experiment_config = "ExperimentConfig",
        .failure_reason = "FailureReason",
        .final_metric_data_list = "FinalMetricDataList",
        .hyper_parameters = "HyperParameters",
        .input_data_config = "InputDataConfig",
        .labeling_job_arn = "LabelingJobArn",
        .last_modified_time = "LastModifiedTime",
        .model_artifacts = "ModelArtifacts",
        .model_package_config = "ModelPackageConfig",
        .output_data_config = "OutputDataConfig",
        .output_model_package_arn = "OutputModelPackageArn",
        .profiler_config = "ProfilerConfig",
        .resource_config = "ResourceConfig",
        .retry_strategy = "RetryStrategy",
        .role_arn = "RoleArn",
        .secondary_status = "SecondaryStatus",
        .secondary_status_transitions = "SecondaryStatusTransitions",
        .stopping_condition = "StoppingCondition",
        .tags = "Tags",
        .tensor_board_output_config = "TensorBoardOutputConfig",
        .training_end_time = "TrainingEndTime",
        .training_job_arn = "TrainingJobArn",
        .training_job_name = "TrainingJobName",
        .training_job_status = "TrainingJobStatus",
        .training_start_time = "TrainingStartTime",
        .training_time_in_seconds = "TrainingTimeInSeconds",
        .tuning_job_arn = "TuningJobArn",
        .vpc_config = "VpcConfig",
    };
};
