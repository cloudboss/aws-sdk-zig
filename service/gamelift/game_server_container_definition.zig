const ContainerDependency = @import("container_dependency.zig").ContainerDependency;
const ContainerEnvironment = @import("container_environment.zig").ContainerEnvironment;
const ContainerMountPoint = @import("container_mount_point.zig").ContainerMountPoint;
const ContainerPortConfiguration = @import("container_port_configuration.zig").ContainerPortConfiguration;

/// Describes the game server container in an existing game server container
/// group. A game
/// server container identifies a container image with your game server build. A
/// game server
/// container is automatically considered essential; if an essential container
/// fails, the entire
/// container group restarts.
///
/// You can update a container definition and deploy the updates to an existing
/// fleet. When
/// creating or updating a game server container group definition, use the
/// property
/// [https://docs.aws.amazon.com/gamelift/latest/apireference/API_GameServerContainerDefinitionInput](https://docs.aws.amazon.com/gamelift/latest/apireference/API_GameServerContainerDefinitionInput).
///
/// **Part of:**
/// [ContainerGroupDefinition](https://docs.aws.amazon.com/gamelift/latest/apireference/API_ContainerGroupDefinition.html)
///
/// **Returned by:**
/// [DescribeContainerGroupDefinition](https://docs.aws.amazon.com/gamelift/latest/apireference/API_DescribeContainerGroupDefinition.html),
/// [ListContainerGroupDefinitions](https://docs.aws.amazon.com/gamelift/latest/apireference/API_ListContainerGroupDefinitions.html),
/// [UpdateContainerGroupDefinition](https://docs.aws.amazon.com/gamelift/latest/apireference/API_UpdateContainerGroupDefinition.html)
pub const GameServerContainerDefinition = struct {
    /// The container definition identifier. Container names are unique within a
    /// container group
    /// definition.
    container_name: ?[]const u8 = null,

    /// Indicates that the container relies on the status of other containers in the
    /// same
    /// container group during startup and shutdown sequences. A container might
    /// have dependencies on
    /// multiple containers.
    depends_on: ?[]const ContainerDependency = null,

    /// A set of environment variables that's passed to the container on startup.
    /// See the
    /// [ContainerDefinition::environment](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ContainerDefinition.html#ECS-Type-ContainerDefinition-environment) parameter in the *Amazon Elastic Container Service API
    /// Reference*.
    environment_override: ?[]const ContainerEnvironment = null,

    /// The URI to the image that Amazon GameLift Servers uses when deploying this
    /// container to a container fleet.
    /// For a more specific identifier, see `ResolvedImageDigest`.
    image_uri: ?[]const u8 = null,

    /// A mount point that binds a path inside the container to a file or directory
    /// on the host
    /// system and lets it access the file or directory.
    mount_points: ?[]const ContainerMountPoint = null,

    /// The set of ports that are available to bind to processes in the container.
    /// For example, a
    /// game server process requires a container port to allow game clients to
    /// connect to it.
    /// Container ports aren't directly accessed by inbound traffic. Amazon GameLift
    /// Servers maps these container
    /// ports to externally accessible connection ports, which are assigned as
    /// needed from the
    /// container fleet's `ConnectionPortRange`.
    port_configuration: ?ContainerPortConfiguration = null,

    /// A unique and immutable identifier for the container image. The digest is a
    /// SHA 256 hash of
    /// the container image manifest.
    resolved_image_digest: ?[]const u8 = null,

    /// The Amazon GameLift Servers server SDK version that the game server is
    /// integrated with. Only game servers
    /// using 5.2.0 or higher are compatible with container fleets.
    server_sdk_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .container_name = "ContainerName",
        .depends_on = "DependsOn",
        .environment_override = "EnvironmentOverride",
        .image_uri = "ImageUri",
        .mount_points = "MountPoints",
        .port_configuration = "PortConfiguration",
        .resolved_image_digest = "ResolvedImageDigest",
        .server_sdk_version = "ServerSdkVersion",
    };
};
