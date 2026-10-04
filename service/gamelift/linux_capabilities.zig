const LinuxCapability = @import("linux_capability.zig").LinuxCapability;

/// A set of Linux capabilities that are added to a container's default Docker
/// configuration
/// for a container defined in the
/// [ContainerGroupDefinition](https://docs.aws.amazon.com/gamelift/latest/apireference/API_ContainerGroupDefinition.html). For more detailed information about these Linux
/// capabilities, see the
/// [capabilities(7)](https://man7.org/linux/man-pages/man7/capabilities.7.html)
/// Linux manual page.
///
/// **Modifying capabilities on an existing container:** To
/// remove a capability, update the `Include` list with only the needed
/// capabilities.
/// To revert back to default capabilities, omit `LinuxCapabilities` within the
/// ContainerDefinition.
///
/// **Part of: **
/// [GameServerContainerDefinition](https://docs.aws.amazon.com/gamelift/latest/apireference/API_GameServerContainerDefinition.html),
/// [GameServerContainerDefinitionInput](https://docs.aws.amazon.com/gamelift/latest/apireference/API_GameServerContainerDefinitionInput.html),
/// [SupportContainerDefinition](https://docs.aws.amazon.com/gamelift/latest/apireference/API_SupportContainerDefinition.html),
/// [SupportContainerDefinitionInput](https://docs.aws.amazon.com/gamelift/latest/apireference/API_SupportContainerDefinitionInput.html)
///
/// **Returned by: **
/// [CreateContainerGroupDefinition](https://docs.aws.amazon.com/gamelift/latest/apireference/API_CreateContainerGroupDefinition.html),
/// [DescribeContainerGroupDefinition](https://docs.aws.amazon.com/gamelift/latest/apireference/API_DescribeContainerGroupDefinition.html),
/// [ListContainerGroupDefinitions](https://docs.aws.amazon.com/gamelift/latest/apireference/API_ListContainerGroupDefinitions.html),
/// [ListContainerGroupDefinitionVersions](https://docs.aws.amazon.com/gamelift/latest/apireference/API_ListContainerGroupDefinitionVersions.html),
/// [UpdateContainerGroupDefinition](https://docs.aws.amazon.com/gamelift/latest/apireference/API_UpdateContainerGroupDefinition.html)
pub const LinuxCapabilities = struct {
    /// The list of Linux capabilities to add to the container's default
    /// configuration.
    /// Specify each capability as a string from the set of supported capability
    /// names (for example,
    /// `NET_BIND_SERVICE` or `SYS_PTRACE`).
    include: ?[]const LinuxCapability = null,

    pub const json_field_names = .{
        .include = "Include",
    };
};
