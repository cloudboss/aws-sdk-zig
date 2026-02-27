const BatchEnvironmentVariable = @import("batch_environment_variable.zig").BatchEnvironmentVariable;
const BatchResourceRequirement = @import("batch_resource_requirement.zig").BatchResourceRequirement;

/// The overrides that are sent to a container.
pub const BatchContainerOverrides = struct {
    /// The command to send to the container that overrides the default command from
    /// the Docker
    /// image or the task definition.
    command: ?[]const []const u8,

    /// The environment variables to send to the container. You can add new
    /// environment
    /// variables, which are added to the container at launch, or you can override
    /// the existing
    /// environment variables from the Docker image or the task definition.
    ///
    /// Environment variables cannot start with "`Batch`". This
    /// naming convention is reserved for variables that Batch sets.
    environment: ?[]const BatchEnvironmentVariable,

    /// The instance type to use for a multi-node parallel job.
    ///
    /// This parameter isn't applicable to single-node container jobs or jobs that
    /// run on
    /// Fargate resources, and shouldn't be provided.
    instance_type: ?[]const u8,

    /// The type and amount of resources to assign to a container. This overrides
    /// the settings
    /// in the job definition. The supported resources include `GPU`,
    /// `MEMORY`, and `VCPU`.
    resource_requirements: ?[]const BatchResourceRequirement,

    pub const json_field_names = .{
        .command = "Command",
        .environment = "Environment",
        .instance_type = "InstanceType",
        .resource_requirements = "ResourceRequirements",
    };
};
