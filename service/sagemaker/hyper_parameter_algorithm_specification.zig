const MetricDefinition = @import("metric_definition.zig").MetricDefinition;
const TrainingInputMode = @import("training_input_mode.zig").TrainingInputMode;

/// Specifies which training algorithm to use for training jobs that a
/// hyperparameter tuning job launches and the metrics to monitor.
pub const HyperParameterAlgorithmSpecification = struct {
    /// The name of the resource algorithm to use for the hyperparameter tuning job.
    /// If you specify a value for this parameter, do not specify a value for
    /// `TrainingImage`.
    algorithm_name: ?[]const u8,

    /// An array of
    /// [MetricDefinition](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_MetricDefinition.html) objects that specify the metrics that the algorithm emits.
    metric_definitions: ?[]const MetricDefinition,

    /// The registry path of the Docker image that contains the training algorithm.
    /// For information about Docker registry paths for built-in algorithms, see
    /// [Algorithms Provided by Amazon SageMaker: Common
    /// Parameters](https://docs.aws.amazon.com/sagemaker/latest/dg/sagemaker-algo-docker-registry-paths.html). SageMaker supports both `registry/repository[:tag]` and `registry/repository[@digest]` image path formats. For more information, see [Using Your Own Algorithms with Amazon SageMaker](https://docs.aws.amazon.com/sagemaker/latest/dg/your-algorithms.html).
    training_image: ?[]const u8,

    training_input_mode: TrainingInputMode,

    pub const json_field_names = .{
        .algorithm_name = "AlgorithmName",
        .metric_definitions = "MetricDefinitions",
        .training_image = "TrainingImage",
        .training_input_mode = "TrainingInputMode",
    };
};
