const MetricDefinition = @import("metric_definition.zig").MetricDefinition;

/// Provides configuration information for the dockerized container where the
/// model algorithm is stored.
pub const ContainerConfig = struct {
    /// The arguments for a container used to run a training job. See How Amazon
    /// SageMaker Runs Your Training Image for additional information. For more
    /// information, see [How Sagemaker runs your training
    /// image](https://docs.aws.amazon.com/sagemaker/latest/dg/your-algorithms-training-algo-dockerfile.html).
    arguments: ?[]const []const u8 = null,

    /// The entrypoint script for a Docker container used to run a training job.
    /// This script takes precedence over the default train processing instructions.
    /// See How Amazon SageMaker Runs Your Training Image for additional
    /// information. For more information, see [How Sagemaker runs your training
    /// image](https://docs.aws.amazon.com/sagemaker/latest/dg/your-algorithms-training-algo-dockerfile.html).
    entrypoint: ?[]const []const u8 = null,

    /// The registry path of the docker image that contains the algorithm. Clean
    /// Rooms ML currently only supports the `registry/repository[:tag]` image path
    /// format. For more information about using images in Clean Rooms ML, see the
    /// [Sagemaker API
    /// reference](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_AlgorithmSpecification.html#sagemaker-Type-AlgorithmSpecification-TrainingImage).
    image_uri: []const u8,

    /// A list of metric definition objects. Each object specifies the metric name
    /// and regular expressions used to parse algorithm logs. Amazon Web Services
    /// Clean Rooms ML publishes each metric to all members' Amazon CloudWatch using
    /// IAM role configured in PutMLConfiguration.
    metric_definitions: ?[]const MetricDefinition = null,

    pub const json_field_names = .{
        .arguments = "arguments",
        .entrypoint = "entrypoint",
        .image_uri = "imageUri",
        .metric_definitions = "metricDefinitions",
    };
};
