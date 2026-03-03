const TaskContainerDependency = @import("task_container_dependency.zig").TaskContainerDependency;
const KeyValuePair = @import("key_value_pair.zig").KeyValuePair;
const FirelensConfiguration = @import("firelens_configuration.zig").FirelensConfiguration;
const LinuxParameters = @import("linux_parameters.zig").LinuxParameters;
const LogConfiguration = @import("log_configuration.zig").LogConfiguration;
const MountPoint = @import("mount_point.zig").MountPoint;
const NetworkInterface = @import("network_interface.zig").NetworkInterface;
const RepositoryCredentials = @import("repository_credentials.zig").RepositoryCredentials;
const ResourceRequirement = @import("resource_requirement.zig").ResourceRequirement;
const Secret = @import("secret.zig").Secret;
const Ulimit = @import("ulimit.zig").Ulimit;

/// The details for the container in this task attempt.
pub const TaskContainerDetails = struct {
    /// The command that's passed to the container. This parameter maps to `Cmd` in
    /// the
    /// [Create a
    /// container](https://docs.docker.com/engine/api/v1.23/#create-a-container)
    /// section of the [Docker Remote
    /// API](https://docs.docker.com/engine/api/v1.23/) and the `COMMAND`
    /// parameter to [docker run](https://docs.docker.com/engine/reference/run/).
    /// For more information, see
    /// [https://docs.docker.com/engine/reference/builder/#cmd](https://docs.docker.com/engine/reference/builder/#cmd).
    command: ?[]const []const u8 = null,

    /// A list of containers that this container depends on.
    depends_on: ?[]const TaskContainerDependency = null,

    /// The environment variables to pass to a container. This parameter maps to
    /// `Env` in
    /// the [Create a
    /// container](https://docs.docker.com/engine/api/v1.23/#create-a-container)
    /// section of the [Docker Remote
    /// API](https://docs.docker.com/engine/api/v1.23/) and the
    /// `--env` option to [docker
    /// run](https://docs.docker.com/engine/reference/run/).
    ///
    /// We don't recommend using plaintext environment variables for sensitive
    /// information, such as
    /// credential data.
    environment: ?[]const KeyValuePair = null,

    /// If the essential parameter of a container is marked as `true`, and that
    /// container
    /// fails or stops for any reason, all other containers that are part of the
    /// task are stopped. If the
    /// `essential` parameter of a container is marked as false, its failure doesn't
    /// affect
    /// the rest of the containers in a task. If this parameter is omitted, a
    /// container is assumed to be
    /// essential.
    ///
    /// All jobs must have at least one essential container. If you have an
    /// application that's
    /// composed of multiple containers, group containers that are used for a common
    /// purpose into
    /// components, and separate the different components into multiple task
    /// definitions. For more
    /// information, see [Application
    /// Architecture](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/application_architecture.html) in the *Amazon Elastic Container Service Developer Guide*.
    essential: ?bool = null,

    /// The exit code returned upon completion.
    exit_code: ?i32 = null,

    /// The FireLens configuration for the container. This is used to specify and
    /// configure a
    /// log router for container logs. For more information, see [Custom
    /// log](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/using_firelens.html) routing in the *Amazon Elastic Container Service Developer
    /// Guide*.
    firelens_configuration: ?FirelensConfiguration = null,

    /// The image used to start a container. This string is passed directly to the
    /// Docker daemon. By
    /// default, images in the Docker Hub registry are available. Other repositories
    /// are specified with
    /// either `repository-url/image:tag` or `repository-url/image@digest`. Up to
    /// 255 letters (uppercase and lowercase), numbers, hyphens, underscores,
    /// colons, periods, forward
    /// slashes, and number signs are allowed. This parameter maps to `Image` in the
    /// [Create a
    /// container](https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker
    /// Remote API](https://docs.docker.com/engine/api/v1.35/) and the `IMAGE`
    /// parameter of the [
    /// *docker
    /// run*
    /// ](https://docs.docker.com/engine/reference/run/#security-configuration).
    image: ?[]const u8 = null,

    /// Linux-specific modifications that are applied to the container, such as
    /// Linux kernel
    /// capabilities. For more information, see
    /// [KernelCapabilities](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_KernelCapabilities.html).
    ///
    /// This parameter is not supported for Windows containers.
    linux_parameters: ?LinuxParameters = null,

    /// The log configuration specification for the container.
    ///
    /// This parameter maps to `LogConfig` in the [Create a
    /// container](https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker
    /// Remote API](https://docs.docker.com/engine/api/v1.35/) and the
    /// `--log-driver` option to [docker
    /// run](https://docs.docker.com/engine/reference/run/#security-configuration).
    ///
    /// By default, containers use the same logging driver that the Docker daemon
    /// uses. However the
    /// container can use a different logging driver than the Docker daemon by
    /// specifying a log driver
    /// with this parameter in the container definition. To use a different logging
    /// driver for a
    /// container, the log system must be configured properly on the container
    /// instance (or on a
    /// different log server for remote logging options). For more information about
    /// the options for
    /// different supported log drivers, see [Configure logging drivers
    /// ](https://docs.docker.com/engine/admin/logging/overview/)
    /// in the *Docker documentation*.
    ///
    /// Amazon ECS currently supports a subset of the logging drivers available to
    /// the Docker daemon
    /// (shown in the `LogConfiguration` data type). Additional log drivers may be
    /// available
    /// in future releases of the Amazon ECS container agent.
    ///
    /// This parameter requires version 1.18 of the Docker Remote API or greater on
    /// your container
    /// instance. To check the Docker Remote API version on your container instance,
    /// log in to your
    /// container instance and run the following command: sudo docker version
    /// `--format
    /// '{{.Server.APIVersion}}'`
    ///
    /// The Amazon ECS container agent running on a container instance must register
    /// the logging drivers
    /// available on that instance with the `ECS_AVAILABLE_LOGGING_DRIVERS`
    /// environment
    /// variable before containers placed on that instance can use these log
    /// configuration options. For
    /// more information, see [Amazon ECS container agent
    /// configuration](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-agent-config.html) in the *Amazon Elastic Container Service Developer Guide*.
    log_configuration: ?LogConfiguration = null,

    /// The name of the CloudWatch Logs log stream that's associated with the
    /// container. The log group for
    /// Batch jobs is /aws/batch/job. Each container attempt receives a log stream
    /// name when they reach
    /// the `RUNNING` status.
    log_stream_name: ?[]const u8 = null,

    /// The mount points for data volumes in your container.
    ///
    /// This parameter maps to `Volumes` in the [Create a
    /// container](https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker
    /// Remote API](https://docs.docker.com/engine/api/v1.35/) and the --volume
    /// option to [docker
    /// run](https://docs.docker.com/engine/reference/run/#security-configuration).
    ///
    /// Windows containers can mount whole directories on the same drive as
    /// `$env:ProgramData`. Windows containers can't mount directories on a
    /// different drive,
    /// and mount point can't be across drives.
    mount_points: ?[]const MountPoint = null,

    /// The name of a container.
    name: ?[]const u8 = null,

    /// The network interfaces that are associated with the job.
    network_interfaces: ?[]const NetworkInterface = null,

    /// When this parameter is `true`, the container is given elevated privileges on
    /// the
    /// host container instance (similar to the `root` user). This parameter maps to
    /// `Privileged` in the [Create a
    /// container](https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker
    /// Remote API](https://docs.docker.com/engine/api/v1.35/) and the
    /// `--privileged` option to [docker
    /// run](https://docs.docker.com/engine/reference/run/#security-configuration).
    ///
    /// This parameter is not supported for Windows containers or tasks run on
    /// Fargate.
    privileged: ?bool = null,

    /// When this parameter is true, the container is given read-only access to its
    /// root file
    /// system. This parameter maps to `ReadonlyRootfs` in the [Create a
    /// container](https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker
    /// Remote API](https://docs.docker.com/engine/api/v1.35/) and the `--read-only`
    /// option to [docker
    /// run](https://docs.docker.com/engine/reference/run/#security-configuration).
    ///
    /// This parameter is not supported for Windows containers.
    readonly_root_filesystem: ?bool = null,

    /// A short (255 max characters) human-readable string to provide additional
    /// details for a
    /// running or stopped container.
    reason: ?[]const u8 = null,

    /// The private repository authentication credentials to use.
    repository_credentials: ?RepositoryCredentials = null,

    /// The type and amount of a resource to assign to a container. The only
    /// supported resource is a
    /// GPU.
    resource_requirements: ?[]const ResourceRequirement = null,

    /// The secrets to pass to the container. For more information, see [Specifying
    /// Sensitive
    /// Data](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/specifying-sensitive-data.html) in the Amazon Elastic Container Service Developer Guide.
    secrets: ?[]const Secret = null,

    /// A list of `ulimits` to set in the container. If a `ulimit` value is
    /// specified in a task definition, it overrides the default values set by
    /// Docker. This parameter
    /// maps to `Ulimits` in the [Create a
    /// container](https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker
    /// Remote API](https://docs.docker.com/engine/api/v1.35/) and the `--ulimit`
    /// option to [docker
    /// run](https://docs.docker.com/engine/reference/run/#security-configuration).
    ///
    /// Amazon ECS tasks hosted on Fargate use the default resource limit values set
    /// by the operating
    /// system with the exception of the nofile resource limit parameter which
    /// Fargate overrides. The
    /// `nofile` resource limit sets a restriction on the number of open files that
    /// a
    /// container can use. The default `nofile` soft limit is `1024` and the
    /// default hard limit is `65535`.
    ///
    /// This parameter requires version 1.18 of the Docker Remote API or greater on
    /// your container
    /// instance. To check the Docker Remote API version on your container instance,
    /// log in to your
    /// container instance and run the following command: sudo docker version
    /// `--format
    /// '{{.Server.APIVersion}}'`
    ///
    /// This parameter is not supported for Windows containers.
    ulimits: ?[]const Ulimit = null,

    /// The user to use inside the container. This parameter maps to User in the
    /// Create a container
    /// section of the Docker Remote API and the --user option to docker run.
    ///
    /// When running tasks using the `host` network mode, don't run containers using
    /// the
    /// `root user (UID 0)`. We recommend using a non-root user for better security.
    ///
    /// You can specify the `user` using the following formats. If specifying a UID
    /// or
    /// GID, you must specify it as a positive integer.
    ///
    /// * `user`
    ///
    /// * `user:group`
    ///
    /// * `uid`
    ///
    /// * `uid:gid`
    ///
    /// * `user:gi`
    ///
    /// * `uid:group`
    ///
    /// * ``
    ///
    /// This parameter is not supported for Windows containers.
    user: ?[]const u8 = null,

    pub const json_field_names = .{
        .command = "command",
        .depends_on = "dependsOn",
        .environment = "environment",
        .essential = "essential",
        .exit_code = "exitCode",
        .firelens_configuration = "firelensConfiguration",
        .image = "image",
        .linux_parameters = "linuxParameters",
        .log_configuration = "logConfiguration",
        .log_stream_name = "logStreamName",
        .mount_points = "mountPoints",
        .name = "name",
        .network_interfaces = "networkInterfaces",
        .privileged = "privileged",
        .readonly_root_filesystem = "readonlyRootFilesystem",
        .reason = "reason",
        .repository_credentials = "repositoryCredentials",
        .resource_requirements = "resourceRequirements",
        .secrets = "secrets",
        .ulimits = "ulimits",
        .user = "user",
    };
};
