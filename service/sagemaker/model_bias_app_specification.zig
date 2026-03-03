const aws = @import("aws");

/// Docker container image configuration object for the model bias job.
pub const ModelBiasAppSpecification = struct {
    /// JSON formatted S3 file that defines bias parameters. For more information on
    /// this JSON configuration file, see [Configure bias
    /// parameters](https://docs.aws.amazon.com/sagemaker/latest/dg/clarify-config-json-monitor-bias-parameters.html).
    config_uri: []const u8,

    /// Sets the environment variables in the Docker container.
    environment: ?[]const aws.map.StringMapEntry = null,

    /// The container image to be run by the model bias job.
    image_uri: []const u8,

    pub const json_field_names = .{
        .config_uri = "ConfigUri",
        .environment = "Environment",
        .image_uri = "ImageUri",
    };
};
