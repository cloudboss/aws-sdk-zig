const aws = @import("aws");

const ContainerMetricsConfig = @import("container_metrics_config.zig").ContainerMetricsConfig;

/// Defines a container that provides the runtime environment for a model that
/// you deploy with an inference component.
pub const InferenceComponentContainerSpecification = struct {
    /// The Amazon S3 path where the model artifacts, which result from model
    /// training, are stored. This path must point to a single gzip compressed tar
    /// archive (.tar.gz suffix).
    artifact_url: ?[]const u8 = null,

    /// The configuration for container metrics scraping. Specifies the metrics
    /// endpoint path and publishing frequency for the inference component's
    /// container. If not specified when `EnableDetailedObservability` is `True`,
    /// the default path `/metrics` on port `8080` is used. For first-party and Deep
    /// Learning Containers (DLC), the endpoint path is determined automatically and
    /// this configuration is optional.
    container_metrics_config: ?ContainerMetricsConfig = null,

    /// The environment variables to set in the Docker container. Each key and value
    /// in the Environment string-to-string map can have length of up to 1024. We
    /// support up to 16 entries in the map.
    environment: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Elastic Container Registry (Amazon ECR) path where the Docker
    /// image for the model is stored.
    image: ?[]const u8 = null,

    pub const json_field_names = .{
        .artifact_url = "ArtifactUrl",
        .container_metrics_config = "ContainerMetricsConfig",
        .environment = "Environment",
        .image = "Image",
    };
};
