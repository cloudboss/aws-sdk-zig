const EksContainerEnvironmentVariable = @import("eks_container_environment_variable.zig").EksContainerEnvironmentVariable;
const EksContainerResourceRequirements = @import("eks_container_resource_requirements.zig").EksContainerResourceRequirements;

/// Object representing any Kubernetes overrides to a job definition that's used
/// in a
/// [SubmitJob](https://docs.aws.amazon.com/batch/latest/APIReference/API_SubmitJob.html) API
/// operation.
pub const EksContainerOverride = struct {
    /// The arguments to the entrypoint to send to the container that overrides the
    /// default
    /// arguments from the Docker image or the job definition. For more information,
    /// see [Dockerfile reference:
    /// CMD](https://docs.docker.com/engine/reference/builder/#cmd)
    /// and [Define a command an arguments for a
    /// pod](https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/) in the *Kubernetes
    /// documentation*.
    args: ?[]const []const u8 = null,

    /// The command to send to the container that overrides the default command from
    /// the Docker
    /// image or the job definition.
    command: ?[]const []const u8 = null,

    /// The environment variables to send to the container. You can add new
    /// environment variables,
    /// which are added to the container at launch. Or, you can override the
    /// existing environment
    /// variables from the Docker image or the job definition.
    ///
    /// Environment variables cannot start with "`AWS_BATCH`". This naming
    /// convention is reserved for variables that Batch sets.
    env: ?[]const EksContainerEnvironmentVariable = null,

    /// The override of the Docker image that's used to start the container.
    image: ?[]const u8 = null,

    /// A pointer to the container that you want to override. The name must match a
    /// unique container
    /// name that you wish to override.
    name: ?[]const u8 = null,

    /// The type and amount of resources to assign to a container. These override
    /// the settings in
    /// the job definition. The supported resources include `memory`, `cpu`, and
    /// `nvidia.com/gpu`. For more information, see [Resource
    /// management for pods and
    /// containers](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/) in the *Kubernetes
    /// documentation*.
    resources: ?EksContainerResourceRequirements = null,

    pub const json_field_names = .{
        .args = "args",
        .command = "command",
        .env = "env",
        .image = "image",
        .name = "name",
        .resources = "resources",
    };
};
