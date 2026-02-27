/// A configuration option setting for the environment.
pub const AwsElasticBeanstalkEnvironmentOptionSetting = struct {
    /// The type of resource that the configuration option is associated with.
    namespace: ?[]const u8,

    /// The name of the option.
    option_name: ?[]const u8,

    /// The name of the resource.
    resource_name: ?[]const u8,

    /// The value of the configuration setting.
    value: ?[]const u8,

    pub const json_field_names = .{
        .namespace = "Namespace",
        .option_name = "OptionName",
        .resource_name = "ResourceName",
        .value = "Value",
    };
};
