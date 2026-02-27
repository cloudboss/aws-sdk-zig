const AwsEcsTaskDefinitionProxyConfigurationProxyConfigurationPropertiesDetails = @import("aws_ecs_task_definition_proxy_configuration_proxy_configuration_properties_details.zig").AwsEcsTaskDefinitionProxyConfigurationProxyConfigurationPropertiesDetails;

/// The configuration details for the App Mesh
/// proxy.
pub const AwsEcsTaskDefinitionProxyConfigurationDetails = struct {
    /// The name of the container that will serve as the App Mesh proxy.
    container_name: ?[]const u8,

    /// The set of network configuration parameters to provide to the Container
    /// Network Interface (CNI) plugin, specified as key-value pairs.
    proxy_configuration_properties: ?[]const AwsEcsTaskDefinitionProxyConfigurationProxyConfigurationPropertiesDetails,

    /// The proxy type.
    type: ?[]const u8,

    pub const json_field_names = .{
        .container_name = "ContainerName",
        .proxy_configuration_properties = "ProxyConfigurationProperties",
        .type = "Type",
    };
};
