const aws = @import("aws");

/// Settings for the model sharding technique that's applied by a model
/// optimization job.
pub const ModelShardingConfig = struct {
    /// The URI of an LMI DLC in Amazon ECR. SageMaker uses this image to run the
    /// optimization.
    image: ?[]const u8 = null,

    /// Environment variables that override the default ones in the model container.
    override_environment: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .image = "Image",
        .override_environment = "OverrideEnvironment",
    };
};
