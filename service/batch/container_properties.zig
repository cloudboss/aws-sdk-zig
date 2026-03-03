const KeyValuePair = @import("key_value_pair.zig").KeyValuePair;
const EphemeralStorage = @import("ephemeral_storage.zig").EphemeralStorage;
const FargatePlatformConfiguration = @import("fargate_platform_configuration.zig").FargatePlatformConfiguration;
const LinuxParameters = @import("linux_parameters.zig").LinuxParameters;
const LogConfiguration = @import("log_configuration.zig").LogConfiguration;
const MountPoint = @import("mount_point.zig").MountPoint;
const NetworkConfiguration = @import("network_configuration.zig").NetworkConfiguration;
const RepositoryCredentials = @import("repository_credentials.zig").RepositoryCredentials;
const ResourceRequirement = @import("resource_requirement.zig").ResourceRequirement;
const RuntimePlatform = @import("runtime_platform.zig").RuntimePlatform;
const Secret = @import("secret.zig").Secret;
const Ulimit = @import("ulimit.zig").Ulimit;
const Volume = @import("volume.zig").Volume;

/// Container properties are used for Amazon ECS based job definitions. These
/// properties to describe the
/// container that's launched as part of a job.
pub const ContainerProperties = struct {
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

    /// Determines whether execute command functionality is turned on for this task.
    /// If `true`, execute
    /// command functionality is turned on all the containers in the task.
    enable_execute_command: ?bool = null,

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
    ///
    /// Environment variables cannot start with "`AWS_BATCH`". This naming
    /// convention is reserved for variables that Batch sets.
    environment: ?[]const KeyValuePair = null,

    /// The amount of ephemeral storage to allocate for the task. This parameter is
    /// used to expand
    /// the total amount of ephemeral storage available, beyond the default amount,
    /// for tasks hosted on
    /// Fargate.
    ephemeral_storage: ?EphemeralStorage = null,

    /// The Amazon Resource Name (ARN) of the execution role that Batch can assume.
    /// For jobs that run on Fargate
    /// resources, you must provide an execution role. For more information, see
    /// [Batch execution IAM
    /// role](https://docs.aws.amazon.com/batch/latest/userguide/execution-IAM-role.html)
    /// in the *Batch User Guide*.
    execution_role_arn: ?[]const u8 = null,

    /// The platform configuration for jobs that are running on Fargate resources.
    /// Jobs that are
    /// running on Amazon EC2 resources must not specify this parameter.
    fargate_platform_configuration: ?FargatePlatformConfiguration = null,

    /// Required. The image used to start a container. This string is passed
    /// directly to the
    /// Docker daemon. Images in the Docker Hub registry are available by default.
    /// Other repositories are
    /// specified with
    /// `
    /// *repository-url*/*image*:*tag*
    /// `.
    /// It can be 255 characters long. It can contain uppercase and lowercase
    /// letters, numbers,
    /// hyphens (-), underscores (_), colons (:), periods (.), forward slashes (/),
    /// and number signs (#). This parameter maps to `Image` in the
    /// [Create a
    /// container](https://docs.docker.com/engine/api/v1.23/#create-a-container)
    /// section of the [Docker Remote
    /// API](https://docs.docker.com/engine/api/v1.23/) and the `IMAGE`
    /// parameter of [docker run](https://docs.docker.com/engine/reference/run/).
    ///
    /// Docker image architecture must match the processor architecture of the
    /// compute resources
    /// that they're scheduled on. For example, ARM-based Docker images can only run
    /// on ARM-based
    /// compute resources.
    ///
    /// * Images in Amazon ECR Public repositories use the full
    ///   `registry/repository[:tag]` or
    /// `registry/repository[@digest]` naming conventions. For example,
    /// `public.ecr.aws/*registry_alias*/*my-web-app*:*latest*
    /// `.
    ///
    /// * Images in Amazon ECR repositories use the full registry and repository URI
    ///   (for example,
    /// `123456789012.dkr.ecr..amazonaws.com/`).
    ///
    /// * Images in official repositories on Docker Hub use a single name (for
    ///   example,
    /// `ubuntu` or `mongo`).
    ///
    /// * Images in other repositories on Docker Hub are qualified with an
    ///   organization name (for
    /// example, `amazon/amazon-ecs-agent`).
    ///
    /// * Images in other online repositories are qualified further by a domain name
    ///   (for example,
    /// `quay.io/assemblyline/ubuntu`).
    image: ?[]const u8 = null,

    /// The instance type to use for a multi-node parallel job. All node groups in a
    /// multi-node
    /// parallel job must use the same instance type.
    ///
    /// This parameter isn't applicable to single-node container jobs or jobs that
    /// run on Fargate
    /// resources, and shouldn't be provided.
    instance_type: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role that the container can assume
    /// for Amazon Web Services permissions. For more
    /// information, see [IAM roles for
    /// tasks](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-iam-roles.html) in the
    /// *Amazon Elastic Container Service Developer Guide*.
    job_role_arn: ?[]const u8 = null,

    /// Linux-specific modifications that are applied to the container, such as
    /// details for device
    /// mappings.
    linux_parameters: ?LinuxParameters = null,

    /// The log configuration specification for the container.
    ///
    /// This parameter maps to `LogConfig` in the [Create a
    /// container](https://docs.docker.com/engine/api/v1.23/#create-a-container)
    /// section of the [Docker Remote
    /// API](https://docs.docker.com/engine/api/v1.23/) and the `--log-driver`
    /// option to [docker run](https://docs.docker.com/engine/reference/run/). By
    /// default, containers use the same logging
    /// driver that the Docker daemon uses. However the container might use a
    /// different logging driver
    /// than the Docker daemon by specifying a log driver with this parameter in the
    /// container
    /// definition. To use a different logging driver for a container, the log
    /// system must be configured
    /// properly on the container instance (or on a different log server for remote
    /// logging options). For
    /// more information on the options for different supported log drivers, see
    /// [Configure logging
    /// drivers](https://docs.docker.com/engine/admin/logging/overview/)
    /// in the Docker documentation.
    ///
    /// Batch currently supports a subset of the logging drivers available to the
    /// Docker daemon
    /// (shown in the
    /// [LogConfiguration](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-batch-jobdefinition-containerproperties-logconfiguration.html) data type).
    ///
    /// This parameter requires version 1.18 of the Docker Remote API or greater on
    /// your
    /// container instance. To check the Docker Remote API version on your container
    /// instance, log in to your
    /// container instance and run the following command: `sudo docker version |
    /// grep "Server API version"`
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

    /// This parameter is deprecated, use `resourceRequirements` to specify the
    /// memory
    /// requirements for the job definition. It's not supported for jobs running on
    /// Fargate resources.
    /// For jobs that run on Amazon EC2 resources, it specifies the memory hard
    /// limit (in MiB) for a
    /// container. If your container attempts to exceed the specified number, it's
    /// terminated. You must
    /// specify at least 4 MiB of memory for a job using this parameter. The memory
    /// hard limit can be
    /// specified in several places. It must be specified for each node at least
    /// once.
    memory: ?i32 = null,

    /// The mount points for data volumes in your container. This parameter maps to
    /// `Volumes` in the [Create a
    /// container](https://docs.docker.com/engine/api/v1.23/#create-a-container)
    /// section of the [Docker Remote
    /// API](https://docs.docker.com/engine/api/v1.23/)
    /// and the `--volume` option to [docker
    /// run](https://docs.docker.com/engine/reference/run/).
    mount_points: ?[]const MountPoint = null,

    /// The network configuration for jobs that are running on Fargate resources.
    /// Jobs that are
    /// running on Amazon EC2 resources must not specify this parameter.
    network_configuration: ?NetworkConfiguration = null,

    /// When this parameter is true, the container is given elevated permissions on
    /// the host
    /// container instance (similar to the `root` user). This parameter maps to
    /// `Privileged` in the [Create a
    /// container](https://docs.docker.com/engine/api/v1.23/#create-a-container)
    /// section of the
    /// [Docker Remote API](https://docs.docker.com/engine/api/v1.23/) and the
    /// `--privileged` option to [docker
    /// run](https://docs.docker.com/engine/reference/run/). The default value is
    /// false.
    ///
    /// This parameter isn't applicable to jobs that are running on Fargate
    /// resources and
    /// shouldn't be provided, or specified as false.
    privileged: ?bool = null,

    /// When this parameter is true, the container is given read-only access to its
    /// root file
    /// system. This parameter maps to `ReadonlyRootfs` in the
    /// [Create a
    /// container](https://docs.docker.com/engine/api/v1.23/#create-a-container)
    /// section of the [Docker Remote
    /// API](https://docs.docker.com/engine/api/v1.23/) and the
    /// `--read-only` option to `docker run`.
    readonly_root_filesystem: ?bool = null,

    /// The private repository authentication credentials to use.
    repository_credentials: ?RepositoryCredentials = null,

    /// The type and amount of resources to assign to a container. The supported
    /// resources include
    /// `GPU`, `MEMORY`, and `VCPU`.
    resource_requirements: ?[]const ResourceRequirement = null,

    /// An object that represents the compute environment architecture for Batch
    /// jobs on
    /// Fargate.
    runtime_platform: ?RuntimePlatform = null,

    /// The secrets for the container. For more information, see [Specifying
    /// sensitive
    /// data](https://docs.aws.amazon.com/batch/latest/userguide/specifying-sensitive-data.html) in the
    /// *Batch User Guide*.
    secrets: ?[]const Secret = null,

    /// A list of `ulimits` to set in the container. This parameter maps to
    /// `Ulimits` in the [Create a
    /// container](https://docs.docker.com/engine/api/v1.23/#create-a-container)
    /// section of the [Docker Remote
    /// API](https://docs.docker.com/engine/api/v1.23/)
    /// and the `--ulimit` option to [docker
    /// run](https://docs.docker.com/engine/reference/run/).
    ///
    /// This parameter isn't applicable to jobs that are running on Fargate
    /// resources and
    /// shouldn't be provided.
    ulimits: ?[]const Ulimit = null,

    /// The user name to use inside the container. This parameter maps to `User` in
    /// the
    /// [Create a
    /// container](https://docs.docker.com/engine/api/v1.23/#create-a-container)
    /// section of the [Docker Remote
    /// API](https://docs.docker.com/engine/api/v1.23/) and the `--user`
    /// option to [docker run](https://docs.docker.com/engine/reference/run/).
    user: ?[]const u8 = null,

    /// This parameter is deprecated, use `resourceRequirements` to specify the vCPU
    /// requirements for the job definition. It's not supported for jobs running on
    /// Fargate resources.
    /// For jobs running on Amazon EC2 resources, it specifies the number of vCPUs
    /// reserved for the
    /// job.
    ///
    /// Each vCPU is equivalent to 1,024 CPU shares. This parameter maps to
    /// `CpuShares`
    /// in the [Create a
    /// container](https://docs.docker.com/engine/api/v1.23/#create-a-container)
    /// section of the [Docker Remote
    /// API](https://docs.docker.com/engine/api/v1.23/) and the
    /// `--cpu-shares` option to [docker
    /// run](https://docs.docker.com/engine/reference/run/). The
    /// number of vCPUs must be specified but can be specified in several places.
    /// You must specify it at
    /// least once for each node.
    vcpus: ?i32 = null,

    /// A list of data volumes used in a job.
    volumes: ?[]const Volume = null,

    pub const json_field_names = .{
        .command = "command",
        .enable_execute_command = "enableExecuteCommand",
        .environment = "environment",
        .ephemeral_storage = "ephemeralStorage",
        .execution_role_arn = "executionRoleArn",
        .fargate_platform_configuration = "fargatePlatformConfiguration",
        .image = "image",
        .instance_type = "instanceType",
        .job_role_arn = "jobRoleArn",
        .linux_parameters = "linuxParameters",
        .log_configuration = "logConfiguration",
        .memory = "memory",
        .mount_points = "mountPoints",
        .network_configuration = "networkConfiguration",
        .privileged = "privileged",
        .readonly_root_filesystem = "readonlyRootFilesystem",
        .repository_credentials = "repositoryCredentials",
        .resource_requirements = "resourceRequirements",
        .runtime_platform = "runtimePlatform",
        .secrets = "secrets",
        .ulimits = "ulimits",
        .user = "user",
        .vcpus = "vcpus",
        .volumes = "volumes",
    };
};
