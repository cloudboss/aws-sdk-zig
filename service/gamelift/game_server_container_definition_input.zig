const ContainerDependency = @import("container_dependency.zig").ContainerDependency;
const ContainerEnvironment = @import("container_environment.zig").ContainerEnvironment;
const ContainerMountPoint = @import("container_mount_point.zig").ContainerMountPoint;
const ContainerPortConfiguration = @import("container_port_configuration.zig").ContainerPortConfiguration;

/// Describes the configuration for a container that runs your game server
/// executable. This
/// definition includes container configuration, resources, and start
/// instructions. Use this data
/// type when creating or updating a game server container group definition. For
/// properties of a
/// deployed container, see
/// [GameServerContainerDefinition](https://docs.aws.amazon.com/gamelift/latest/apireference/API_GameServerContainerDefinition.html). A game server
/// container is automatically considered essential; if an essential container
/// fails, the entire
/// container group restarts.
///
/// **Use with: **
/// [CreateContainerGroupDefinition](https://docs.aws.amazon.com/gamelift/latest/apireference/API_CreateContainerGroupDefinition.html),
/// [UpdateContainerGroupDefinition](https://docs.aws.amazon.com/gamelift/latest/apireference/API_UpdateContainerGroupDefinition.html)
pub const GameServerContainerDefinitionInput = struct {
    /// A string that uniquely identifies the container definition within a
    /// container
    /// group.
    container_name: []const u8,

    /// Establishes dependencies between this container and the status of other
    /// containers in the
    /// same container group. A container can have dependencies on multiple
    /// different containers.
    ///
    /// You can use dependencies to establish a startup/shutdown sequence across the
    /// container
    /// group. For example, you might specify that *ContainerB* has a
    /// `START` dependency on *ContainerA*. This dependency means that
    /// *ContainerB* can't start until after *ContainerA* has
    /// started. This dependency is reversed on shutdown, which means that
    /// *ContainerB* must shut down before *ContainerA* can
    /// shut down.
    depends_on: ?[]const ContainerDependency,

    /// A set of environment variables to pass to the container on startup. See the
    /// [ContainerDefinition::environment](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ContainerDefinition.html#ECS-Type-ContainerDefinition-environment) parameter in the *Amazon Elastic Container Service API
    /// Reference*.
    environment_override: ?[]const ContainerEnvironment,

    /// The location of the container image to deploy to a container fleet. Provide
    /// an image in an
    /// Amazon Elastic Container Registry public or private repository. The
    /// repository must be in the same Amazon Web Services account and
    /// Amazon Web Services Region where you're creating the container group
    /// definition. For limits on image size,
    /// see [Amazon GameLift Servers endpoints and
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/gamelift.html). You
    /// can use any of the following image URI formats:
    ///
    /// * Image ID only: `[AWS account].dkr.ecr.[AWS
    ///   region].amazonaws.com/[repository
    /// ID]`
    ///
    /// * Image ID and digest: `[AWS account].dkr.ecr.[AWS
    /// region].amazonaws.com/[repository ID]@[digest]`
    ///
    /// * Image ID and tag: `[AWS account].dkr.ecr.[AWS
    ///   region].amazonaws.com/[repository
    /// ID]:[tag]`
    image_uri: []const u8,

    /// A mount point that binds a path inside the container to a file or directory
    /// on the host
    /// system and lets it access the file or directory.
    mount_points: ?[]const ContainerMountPoint,

    /// A set of ports that Amazon GameLift Servers can assign to processes in a
    /// container. The container port
    /// configuration must have enough ports for each container process that accepts
    /// inbound traffic
    /// connections. For example, a game server process requires a container port to
    /// allow game
    /// clients to connect to it. A container port configuration can have can have
    /// one or more
    /// container port ranges. Each range specifies starting and ending values as
    /// well as the
    /// supported network protocol.
    ///
    /// Container ports aren't directly accessed by inbound traffic. Amazon GameLift
    /// Servers maps each container
    /// port to an externally accessible connection port (see the container fleet
    /// property
    /// `ConnectionPortRange`).
    port_configuration: ContainerPortConfiguration,

    /// The Amazon GameLift Servers server SDK version that the game server is
    /// integrated with. Only game servers
    /// using 5.2.0 or higher are compatible with container fleets.
    server_sdk_version: []const u8,

    pub const json_field_names = .{
        .container_name = "ContainerName",
        .depends_on = "DependsOn",
        .environment_override = "EnvironmentOverride",
        .image_uri = "ImageUri",
        .mount_points = "MountPoints",
        .port_configuration = "PortConfiguration",
        .server_sdk_version = "ServerSdkVersion",
    };
};
