const EcsEnvironmentVariable = @import("ecs_environment_variable.zig").EcsEnvironmentVariable;
const EcsEnvironmentFile = @import("ecs_environment_file.zig").EcsEnvironmentFile;
const EcsResourceRequirement = @import("ecs_resource_requirement.zig").EcsResourceRequirement;

/// The overrides that are sent to a container. An empty container override can
/// be passed
/// in. An example of an empty container override is `{"containerOverrides": [ ]
/// }`.
/// If a non-empty container override is specified, the `name` parameter must be
/// included.
pub const EcsContainerOverride = struct {
    /// The command to send to the container that overrides the default command from
    /// the Docker
    /// image or the task definition. You must also specify a container name.
    command: ?[]const []const u8,

    /// The number of `cpu` units reserved for the container, instead of the default
    /// value from the task definition. You must also specify a container name.
    cpu: ?i32,

    /// The environment variables to send to the container. You can add new
    /// environment
    /// variables, which are added to the container at launch, or you can override
    /// the existing
    /// environment variables from the Docker image or the task definition. You must
    /// also specify a
    /// container name.
    environment: ?[]const EcsEnvironmentVariable,

    /// A list of files containing the environment variables to pass to a container,
    /// instead of
    /// the value from the container definition.
    environment_files: ?[]const EcsEnvironmentFile,

    /// The hard limit (in MiB) of memory to present to the container, instead of
    /// the default
    /// value from the task definition. If your container attempts to exceed the
    /// memory specified
    /// here, the container is killed. You must also specify a container name.
    memory: ?i32,

    /// The soft limit (in MiB) of memory to reserve for the container, instead of
    /// the default
    /// value from the task definition. You must also specify a container name.
    memory_reservation: ?i32,

    /// The name of the container that receives the override. This parameter is
    /// required if any
    /// override is specified.
    name: ?[]const u8,

    /// The type and amount of a resource to assign to a container, instead of the
    /// default value
    /// from the task definition. The only supported resource is a GPU.
    resource_requirements: ?[]const EcsResourceRequirement,

    pub const json_field_names = .{
        .command = "Command",
        .cpu = "Cpu",
        .environment = "Environment",
        .environment_files = "EnvironmentFiles",
        .memory = "Memory",
        .memory_reservation = "MemoryReservation",
        .name = "Name",
        .resource_requirements = "ResourceRequirements",
    };
};
