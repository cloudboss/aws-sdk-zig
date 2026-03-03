const ContainerDependency = @import("container_dependency.zig").ContainerDependency;
const ContainerEnvironment = @import("container_environment.zig").ContainerEnvironment;
const ContainerHealthCheck = @import("container_health_check.zig").ContainerHealthCheck;
const ContainerMountPoint = @import("container_mount_point.zig").ContainerMountPoint;
const ContainerPortConfiguration = @import("container_port_configuration.zig").ContainerPortConfiguration;

/// Describes a support container in a container group. You can define a support
/// container in
/// either a game server container group or a per-instance container group.
/// Support containers
/// don't run game server processes.
///
/// This definition includes container configuration, resources, and start
/// instructions. Use
/// this data type when creating or updating a container group definition. For
/// properties of a
/// deployed support container, see
/// [SupportContainerDefinition](https://docs.aws.amazon.com/gamelift/latest/apireference/API_SupportContainerDefinition.html).
///
/// **Use with: **
/// [CreateContainerGroupDefinition](https://docs.aws.amazon.com/gamelift/latest/apireference/API_CreateContainerGroupDefinition.html),
/// [UpdateContainerGroupDefinition](https://docs.aws.amazon.com/gamelift/latest/apireference/API_UpdateContainerGroupDefinition.html)
pub const SupportContainerDefinitionInput = struct {
    /// A string that uniquely identifies the container definition within a
    /// container
    /// group.
    container_name: []const u8,

    /// Establishes dependencies between this container and the status of other
    /// containers in the
    /// same container group. A container can have dependencies on multiple
    /// different containers.
    ///
    /// .
    ///
    /// You can use dependencies to establish a startup/shutdown sequence across the
    /// container
    /// group. For example, you might specify that *ContainerB* has a
    /// `START` dependency on *ContainerA*. This dependency means that
    /// *ContainerB* can't start until after *ContainerA* has
    /// started. This dependency is reversed on shutdown, which means that
    /// *ContainerB* must shut down before *ContainerA* can
    /// shut down.
    depends_on: ?[]const ContainerDependency = null,

    /// A set of environment variables to pass to the container on startup. See the
    /// [ContainerDefinition::environment](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ContainerDefinition.html#ECS-Type-ContainerDefinition-environment) parameter in the *Amazon Elastic Container Service API
    /// Reference*.
    environment_override: ?[]const ContainerEnvironment = null,

    /// Flags the container as vital for the container group to function properly.
    /// If an essential
    /// container fails, the entire container group restarts. At least one support
    /// container in a
    /// per-instance container group must be essential. When flagging a container as
    /// essential, also
    /// configure a health check so that the container can signal that it's healthy.
    essential: ?bool = null,

    /// Configuration for a non-terminal health check. A container automatically
    /// restarts if it
    /// stops functioning. With a health check, you can define additional reasons to
    /// flag a container
    /// as unhealthy and restart it. If an essential container fails a health check,
    /// the entire
    /// container group restarts.
    health_check: ?ContainerHealthCheck = null,

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

    /// A specified amount of memory (in MiB) to reserve for this container. If you
    /// don't specify
    /// a container-specific memory limit, the container shares the container
    /// group's total memory
    /// allocation.
    ///
    /// **Related data type: **
    /// [ContainerGroupDefinition](https://docs.aws.amazon.com/gamelift/latest/apireference/API_ContainerGroupDefinition.html)TotalMemoryLimitMebibytes``
    memory_hard_limit_mebibytes: ?i32 = null,

    /// A mount point that binds a path inside the container to a file or directory
    /// on the host
    /// system and lets it access the file or directory.
    mount_points: ?[]const ContainerMountPoint = null,

    /// A set of ports that Amazon GameLift Servers can assign to processes in a
    /// container. The container port
    /// configuration must have enough ports for each container process that accepts
    /// inbound traffic
    /// connections. A container port configuration can have can have one or more
    /// container port
    /// ranges. Each range specifies starting and ending values as well as the
    /// supported network
    /// protocol.
    ///
    /// Container ports aren't directly accessed by inbound traffic. Amazon GameLift
    /// Servers maps each container
    /// port to an externally accessible connection port (see the container fleet
    /// property
    /// `ConnectionPortRange`).
    port_configuration: ?ContainerPortConfiguration = null,

    /// The number of vCPU units to reserve for this container. The container can
    /// use more
    /// resources when needed, if available. If you don't reserve CPU units for this
    /// container, it
    /// shares the container group's total vCPU limit.
    ///
    /// **Related data type: **
    /// [ContainerGroupDefinition](https://docs.aws.amazon.com/gamelift/latest/apireference/API_ContainerGroupDefinition.html) TotalCpuLimit
    vcpu: ?f64 = null,

    pub const json_field_names = .{
        .container_name = "ContainerName",
        .depends_on = "DependsOn",
        .environment_override = "EnvironmentOverride",
        .essential = "Essential",
        .health_check = "HealthCheck",
        .image_uri = "ImageUri",
        .memory_hard_limit_mebibytes = "MemoryHardLimitMebibytes",
        .mount_points = "MountPoints",
        .port_configuration = "PortConfiguration",
        .vcpu = "Vcpu",
    };
};
