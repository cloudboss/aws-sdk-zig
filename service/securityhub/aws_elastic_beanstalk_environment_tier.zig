/// Contains information about the tier of the environment.
pub const AwsElasticBeanstalkEnvironmentTier = struct {
    /// The name of the environment tier. Valid values are `WebServer` or `Worker`.
    name: ?[]const u8,

    /// The type of environment tier. Valid values are `Standard` or `SQS/HTTP`.
    type: ?[]const u8,

    /// The version of the environment tier.
    version: ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
        .type = "Type",
        .version = "Version",
    };
};
