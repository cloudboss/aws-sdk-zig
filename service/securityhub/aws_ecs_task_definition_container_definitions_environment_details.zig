/// An environment variable to pass to the container.
pub const AwsEcsTaskDefinitionContainerDefinitionsEnvironmentDetails = struct {
    /// The name of the environment variable.
    name: ?[]const u8 = null,

    /// The value of the environment variable.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
