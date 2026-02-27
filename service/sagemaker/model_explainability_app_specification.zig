const aws = @import("aws");

/// Docker container image configuration object for the model explainability
/// job.
pub const ModelExplainabilityAppSpecification = struct {
    /// JSON formatted Amazon S3 file that defines explainability parameters. For
    /// more information on this JSON configuration file, see [Configure model
    /// explainability
    /// parameters](https://docs.aws.amazon.com/sagemaker/latest/dg/clarify-config-json-monitor-model-explainability-parameters.html).
    config_uri: []const u8,

    /// Sets the environment variables in the Docker container.
    environment: ?[]const aws.map.StringMapEntry,

    /// The container image to be run by the model explainability job.
    image_uri: []const u8,

    pub const json_field_names = .{
        .config_uri = "ConfigUri",
        .environment = "Environment",
        .image_uri = "ImageUri",
    };
};
