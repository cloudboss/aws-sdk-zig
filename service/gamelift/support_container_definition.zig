const ContainerDependency = @import("container_dependency.zig").ContainerDependency;
const ContainerEnvironment = @import("container_environment.zig").ContainerEnvironment;
const ContainerHealthCheck = @import("container_health_check.zig").ContainerHealthCheck;
const ContainerMountPoint = @import("container_mount_point.zig").ContainerMountPoint;
const ContainerPortConfiguration = @import("container_port_configuration.zig").ContainerPortConfiguration;

/// Describes a support container in a container group. A support container
/// might be in a game
/// server container group or a per-instance container group. Support containers
/// don't run game
/// server processes.
///
/// You can update a support container definition and deploy the updates to an
/// existing fleet.
/// When creating or updating a game server container group definition, use the
/// property
/// [GameServerContainerDefinitionInput](https://docs.aws.amazon.com/gamelift/latest/apireference/API_GameServerContainerDefinitionInput.html).
///
/// **Part of:**
/// [ContainerGroupDefinition](https://docs.aws.amazon.com/gamelift/latest/apireference/API_ContainerGroupDefinition.html)
///
/// **Returned by:**
/// [DescribeContainerGroupDefinition](https://docs.aws.amazon.com/gamelift/latest/apireference/API_DescribeContainerGroupDefinition.html),
/// [ListContainerGroupDefinitions](https://docs.aws.amazon.com/gamelift/latest/apireference/API_ListContainerGroupDefinitions.html),
/// [UpdateContainerGroupDefinition](https://docs.aws.amazon.com/gamelift/latest/apireference/API_UpdateContainerGroupDefinition.html)
pub const SupportContainerDefinition = struct {
    /// The container definition identifier. Container names are unique within a
    /// container group
    /// definition.
    container_name: ?[]const u8,

    /// Indicates that the container relies on the status of other containers in the
    /// same
    /// container group during its startup and shutdown sequences. A container might
    /// have dependencies
    /// on multiple containers.
    depends_on: ?[]const ContainerDependency,

    /// A set of environment variables that's passed to the container on startup.
    /// See the
    /// [ContainerDefinition::environment](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ContainerDefinition.html#ECS-Type-ContainerDefinition-environment) parameter in the *Amazon Elastic Container Service API
    /// Reference*.
    environment_override: ?[]const ContainerEnvironment,

    /// Indicates whether the container is vital to the container group. If an
    /// essential container
    /// fails, the entire container group restarts.
    essential: ?bool,

    /// A configuration for a non-terminal health check. A support container
    /// automatically
    /// restarts if it stops functioning or if it fails this health check.
    health_check: ?ContainerHealthCheck,

    /// The URI to the image that Amazon GameLift Servers deploys to a container
    /// fleet. For a more specific
    /// identifier, see `ResolvedImageDigest`.
    image_uri: ?[]const u8,

    /// The amount of memory that Amazon GameLift Servers makes available to the
    /// container. If memory limits
    /// aren't set for an individual container, the container shares the container
    /// group's total
    /// memory allocation.
    ///
    /// **Related data type: **
    /// [ContainerGroupDefinition
    /// TotalMemoryLimitMebibytes](https://docs.aws.amazon.com/gamelift/latest/apireference/API_ContainerGroupDefinition.html)
    memory_hard_limit_mebibytes: ?i32,

    /// A mount point that binds a path inside the container to a file or directory
    /// on the host
    /// system and lets it access the file or directory.
    mount_points: ?[]const ContainerMountPoint,

    /// A set of ports that allow access to the container from external users.
    /// Processes running
    /// in the container can bind to a one of these ports. Container ports aren't
    /// directly accessed by
    /// inbound traffic. Amazon GameLift Servers maps these container ports to
    /// externally accessible connection ports,
    /// which are assigned as needed from the container fleet's
    /// `ConnectionPortRange`.
    port_configuration: ?ContainerPortConfiguration,

    /// A unique and immutable identifier for the container image. The digest is a
    /// SHA 256 hash of
    /// the container image manifest.
    resolved_image_digest: ?[]const u8,

    /// The number of vCPU units that are reserved for the container. If no
    /// resources are
    /// reserved, the container shares the total vCPU limit for the container group.
    ///
    /// **Related data type: **
    /// [ContainerGroupDefinition
    /// TotalVcpuLimit](https://docs.aws.amazon.com/gamelift/latest/apireference/API_ContainerGroupDefinition.html)
    vcpu: ?f64,

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
        .resolved_image_digest = "ResolvedImageDigest",
        .vcpu = "Vcpu",
    };
};
