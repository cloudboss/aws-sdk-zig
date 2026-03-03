const MetricDefinition = @import("metric_definition.zig").MetricDefinition;
const TrainingImageConfig = @import("training_image_config.zig").TrainingImageConfig;
const TrainingInputMode = @import("training_input_mode.zig").TrainingInputMode;

/// Specifies the training algorithm to use in a
/// [CreateTrainingJob](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateTrainingJob.html) request.
///
/// SageMaker uses its own SageMaker account credentials to pull and access
/// built-in algorithms so built-in algorithms are universally accessible across
/// all Amazon Web Services accounts. As a result, built-in algorithms have
/// standard, unrestricted access. You cannot restrict built-in algorithms using
/// IAM roles. Use custom algorithms if you require specific access controls.
///
/// For more information about algorithms provided by SageMaker, see
/// [Algorithms](https://docs.aws.amazon.com/sagemaker/latest/dg/algos.html).
/// For information about using your own algorithms, see [Using Your Own
/// Algorithms with Amazon
/// SageMaker](https://docs.aws.amazon.com/sagemaker/latest/dg/your-algorithms.html).
pub const AlgorithmSpecification = struct {
    /// The name of the algorithm resource to use for the training job. This must be
    /// an algorithm resource that you created or subscribe to on Amazon Web
    /// Services Marketplace.
    ///
    /// You must specify either the algorithm name to the `AlgorithmName` parameter
    /// or the image URI of the algorithm container to the `TrainingImage`
    /// parameter.
    ///
    /// Note that the `AlgorithmName` parameter is mutually exclusive with the
    /// `TrainingImage` parameter. If you specify a value for the `AlgorithmName`
    /// parameter, you can't specify a value for `TrainingImage`, and vice versa.
    ///
    /// If you specify values for both parameters, the training job might break; if
    /// you don't specify any value for both parameters, the training job might
    /// raise a `null` error.
    algorithm_name: ?[]const u8 = null,

    /// The arguments for a container used to run a training job. See [How Amazon
    /// SageMaker Runs Your Training
    /// Image](https://docs.aws.amazon.com/sagemaker/latest/dg/your-algorithms-training-algo-dockerfile.html) for additional information.
    container_arguments: ?[]const []const u8 = null,

    /// The [entrypoint script for a Docker
    /// container](https://docs.docker.com/engine/reference/builder/) used to run a
    /// training job. This script takes precedence over the default train processing
    /// instructions. See [How Amazon SageMaker Runs Your Training
    /// Image](https://docs.aws.amazon.com/sagemaker/latest/dg/your-algorithms-training-algo-dockerfile.html) for more information.
    container_entrypoint: ?[]const []const u8 = null,

    /// To generate and save time-series metrics during training, set to `true`. The
    /// default is `false` and time-series metrics aren't generated except in the
    /// following cases:
    ///
    /// * You use one of the SageMaker built-in algorithms
    /// * You use one of the following [Prebuilt SageMaker Docker
    ///   Images](https://docs.aws.amazon.com/sagemaker/latest/dg/pre-built-containers-frameworks-deep-learning.html):
    ///
    /// * Tensorflow (version >= 1.15)
    /// * MXNet (version >= 1.6)
    /// * PyTorch (version >= 1.3)
    ///
    /// * You specify at least one
    ///   [MetricDefinition](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_MetricDefinition.html)
    enable_sage_maker_metrics_time_series: ?bool = null,

    /// A list of metric definition objects. Each object specifies the metric name
    /// and regular expressions used to parse algorithm logs. SageMaker publishes
    /// each metric to Amazon CloudWatch.
    metric_definitions: ?[]const MetricDefinition = null,

    /// The registry path of the Docker image that contains the training algorithm.
    /// For information about docker registry paths for SageMaker built-in
    /// algorithms, see [Docker Registry Paths and Example
    /// Code](https://docs.aws.amazon.com/sagemaker/latest/dg/sagemaker-algo-docker-registry-paths.html) in the *Amazon SageMaker developer guide*. SageMaker supports both `registry/repository[:tag]` and `registry/repository[@digest]` image path formats. For more information about using your custom training container, see [Using Your Own Algorithms with Amazon SageMaker](https://docs.aws.amazon.com/sagemaker/latest/dg/your-algorithms.html).
    ///
    /// You must specify either the algorithm name to the `AlgorithmName` parameter
    /// or the image URI of the algorithm container to the `TrainingImage`
    /// parameter.
    ///
    /// For more information, see the note in the `AlgorithmName` parameter
    /// description.
    training_image: ?[]const u8 = null,

    /// The configuration to use an image from a private Docker registry for a
    /// training job.
    training_image_config: ?TrainingImageConfig = null,

    training_input_mode: TrainingInputMode,

    pub const json_field_names = .{
        .algorithm_name = "AlgorithmName",
        .container_arguments = "ContainerArguments",
        .container_entrypoint = "ContainerEntrypoint",
        .enable_sage_maker_metrics_time_series = "EnableSageMakerMetricsTimeSeries",
        .metric_definitions = "MetricDefinitions",
        .training_image = "TrainingImage",
        .training_image_config = "TrainingImageConfig",
        .training_input_mode = "TrainingInputMode",
    };
};
