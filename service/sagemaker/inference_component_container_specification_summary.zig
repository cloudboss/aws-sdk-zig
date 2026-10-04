const aws = @import("aws");

const ContainerMetricsConfig = @import("container_metrics_config.zig").ContainerMetricsConfig;
const DeployedImage = @import("deployed_image.zig").DeployedImage;

/// Details about the resources that are deployed with this inference component.
pub const InferenceComponentContainerSpecificationSummary = struct {
    /// The Amazon S3 path where the model artifacts are stored.
    artifact_url: ?[]const u8 = null,

    /// The container metrics scraping configuration for this inference component,
    /// including the metrics endpoint path and publishing frequency.
    container_metrics_config: ?ContainerMetricsConfig = null,

    deployed_image: ?DeployedImage = null,

    /// The environment variables to set in the Docker container.
    environment: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .artifact_url = "ArtifactUrl",
        .container_metrics_config = "ContainerMetricsConfig",
        .deployed_image = "DeployedImage",
        .environment = "Environment",
    };
};
