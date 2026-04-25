const ContainerDependency = @import("container_dependency.zig").ContainerDependency;
const KeyValuePair = @import("key_value_pair.zig").KeyValuePair;
const EnvironmentFile = @import("environment_file.zig").EnvironmentFile;
const FirelensConfiguration = @import("firelens_configuration.zig").FirelensConfiguration;
const HealthCheck = @import("health_check.zig").HealthCheck;
const DaemonLinuxParameters = @import("daemon_linux_parameters.zig").DaemonLinuxParameters;
const LogConfiguration = @import("log_configuration.zig").LogConfiguration;
const MountPoint = @import("mount_point.zig").MountPoint;
const RepositoryCredentials = @import("repository_credentials.zig").RepositoryCredentials;
const ContainerRestartPolicy = @import("container_restart_policy.zig").ContainerRestartPolicy;
const Secret = @import("secret.zig").Secret;
const SystemControl = @import("system_control.zig").SystemControl;
const Ulimit = @import("ulimit.zig").Ulimit;

/// A container definition for a daemon task. Daemon container definitions
/// describe the containers that run as part of a daemon task on container
/// instances managed by capacity providers.
pub const DaemonContainerDefinition = struct {
    /// The command that's passed to the container.
    command: ?[]const []const u8 = null,

    /// The number of `cpu` units reserved for the container.
    cpu: i32 = 0,

    /// The dependencies defined for container startup and shutdown. A container can
    /// contain multiple dependencies on other containers in a task definition.
    depends_on: ?[]const ContainerDependency = null,

    /// The entry point that's passed to the container.
    entry_point: ?[]const []const u8 = null,

    /// The environment variables to pass to a container.
    environment: ?[]const KeyValuePair = null,

    /// A list of files containing the environment variables to pass to a container.
    environment_files: ?[]const EnvironmentFile = null,

    /// If the `essential` parameter of a container is marked as `true`, and that
    /// container fails or stops for any reason, all other containers that are part
    /// of the task are stopped.
    essential: ?bool = null,

    /// The FireLens configuration for the container. This is used to specify and
    /// configure a log router for container logs.
    firelens_configuration: ?FirelensConfiguration = null,

    /// The container health check command and associated configuration parameters
    /// for the container.
    health_check: ?HealthCheck = null,

    /// The image used to start the container. This string is passed directly to the
    /// Docker daemon. Images in the Docker Hub registry are available by default.
    /// Other repositories are specified with either `
    /// *repository-url*/*image*:*tag* ` or ` *repository-url*/*image*@*digest* `.
    image: []const u8,

    /// When this parameter is `true`, you can deploy containerized applications
    /// that require `stdin` or a `tty` to be allocated.
    interactive: ?bool = null,

    /// Linux-specific modifications that are applied to the container
    /// configuration, such as Linux kernel capabilities.
    linux_parameters: ?DaemonLinuxParameters = null,

    /// The log configuration specification for the container.
    log_configuration: ?LogConfiguration = null,

    /// The amount (in MiB) of memory to present to the container. If the container
    /// attempts to exceed the memory specified here, the container is killed.
    memory: ?i32 = null,

    /// The soft limit (in MiB) of memory to reserve for the container.
    memory_reservation: ?i32 = null,

    /// The mount points for data volumes in your container.
    mount_points: ?[]const MountPoint = null,

    /// The name of the container. Up to 255 letters (uppercase and lowercase),
    /// numbers, underscores, and hyphens are allowed.
    name: ?[]const u8 = null,

    /// When this parameter is true, the container is given elevated privileges on
    /// the host container instance (similar to the `root` user).
    privileged: ?bool = null,

    /// When this parameter is `true`, a TTY is allocated.
    pseudo_terminal: ?bool = null,

    /// When this parameter is true, the container is given read-only access to its
    /// root file system.
    readonly_root_filesystem: ?bool = null,

    /// The private repository authentication credentials to use.
    repository_credentials: ?RepositoryCredentials = null,

    /// The restart policy for the container. When you set up a restart policy,
    /// Amazon ECS can restart the container without needing to replace the task.
    restart_policy: ?ContainerRestartPolicy = null,

    /// The secrets to pass to the container.
    secrets: ?[]const Secret = null,

    /// Time duration (in seconds) to wait before giving up on resolving
    /// dependencies for a container.
    start_timeout: ?i32 = null,

    /// Time duration (in seconds) to wait before the container is forcefully killed
    /// if it doesn't exit normally on its own.
    stop_timeout: ?i32 = null,

    /// A list of namespaced kernel parameters to set in the container.
    system_controls: ?[]const SystemControl = null,

    /// A list of `ulimits` to set in the container.
    ulimits: ?[]const Ulimit = null,

    /// The user to use inside the container.
    user: ?[]const u8 = null,

    /// The working directory to run commands inside the container in.
    working_directory: ?[]const u8 = null,

    pub const json_field_names = .{
        .command = "command",
        .cpu = "cpu",
        .depends_on = "dependsOn",
        .entry_point = "entryPoint",
        .environment = "environment",
        .environment_files = "environmentFiles",
        .essential = "essential",
        .firelens_configuration = "firelensConfiguration",
        .health_check = "healthCheck",
        .image = "image",
        .interactive = "interactive",
        .linux_parameters = "linuxParameters",
        .log_configuration = "logConfiguration",
        .memory = "memory",
        .memory_reservation = "memoryReservation",
        .mount_points = "mountPoints",
        .name = "name",
        .privileged = "privileged",
        .pseudo_terminal = "pseudoTerminal",
        .readonly_root_filesystem = "readonlyRootFilesystem",
        .repository_credentials = "repositoryCredentials",
        .restart_policy = "restartPolicy",
        .secrets = "secrets",
        .start_timeout = "startTimeout",
        .stop_timeout = "stopTimeout",
        .system_controls = "systemControls",
        .ulimits = "ulimits",
        .user = "user",
        .working_directory = "workingDirectory",
    };
};
