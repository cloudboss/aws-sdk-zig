const ContainerMountPointAccessLevel = @import("container_mount_point_access_level.zig").ContainerMountPointAccessLevel;

/// A mount point that binds a container to a file or directory on the host
/// system.
///
/// **Part of:**
/// [GameServerContainerDefinition](https://docs.aws.amazon.com/gamelift/latest/apireference/API_GameServerContainerDefinition.html), [https://docs.aws.amazon.com/gamelift/latest/apireference/API_GameServerContainerDefinitionInput.html](https://docs.aws.amazon.com/gamelift/latest/apireference/API_GameServerContainerDefinitionInput.html), [SupportContainerDefinition](https://docs.aws.amazon.com/gamelift/latest/apireference/API_SupportContainerDefinition.html), [https://docs.aws.amazon.com/gamelift/latest/apireference/API_SupportContainerDefinitionInput.html](https://docs.aws.amazon.com/gamelift/latest/apireference/API_SupportContainerDefinitionInput.html)
pub const ContainerMountPoint = struct {
    /// The type of access for the container.
    access_level: ?ContainerMountPointAccessLevel = null,

    /// The mount path on the container. If this property isn't set, the instance
    /// path is
    /// used.
    container_path: ?[]const u8 = null,

    /// The path to the source file or directory.
    instance_path: []const u8,

    pub const json_field_names = .{
        .access_level = "AccessLevel",
        .container_path = "ContainerPath",
        .instance_path = "InstancePath",
    };
};
