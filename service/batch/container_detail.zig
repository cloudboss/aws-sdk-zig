const KeyValuePair = @import("key_value_pair.zig").KeyValuePair;
const EphemeralStorage = @import("ephemeral_storage.zig").EphemeralStorage;
const FargatePlatformConfiguration = @import("fargate_platform_configuration.zig").FargatePlatformConfiguration;
const LinuxParameters = @import("linux_parameters.zig").LinuxParameters;
const LogConfiguration = @import("log_configuration.zig").LogConfiguration;
const MountPoint = @import("mount_point.zig").MountPoint;
const NetworkConfiguration = @import("network_configuration.zig").NetworkConfiguration;
const NetworkInterface = @import("network_interface.zig").NetworkInterface;
const RepositoryCredentials = @import("repository_credentials.zig").RepositoryCredentials;
const ResourceRequirement = @import("resource_requirement.zig").ResourceRequirement;
const RuntimePlatform = @import("runtime_platform.zig").RuntimePlatform;
const Secret = @import("secret.zig").Secret;
const Ulimit = @import("ulimit.zig").Ulimit;
const Volume = @import("volume.zig").Volume;

/// An object that represents the details of a container that's part of a job.
pub const ContainerDetail = struct {
    /// The command that's passed to the container.
    command: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the container instance that the container
    /// is running on.
    container_instance_arn: ?[]const u8 = null,

    /// Determines whether execute command functionality is turned on for this task.
    /// If `true`, execute
    /// command functionality is turned on all the containers in the task.
    enable_execute_command: ?bool = null,

    /// The environment variables to pass to a container.
    ///
    /// Environment variables cannot start with "`AWS_BATCH`". This naming
    /// convention is reserved for variables that Batch sets.
    environment: ?[]const KeyValuePair = null,

    /// The amount of ephemeral storage allocated for the task. This parameter is
    /// used to expand the
    /// total amount of ephemeral storage available, beyond the default amount, for
    /// tasks hosted on
    /// Fargate.
    ephemeral_storage: ?EphemeralStorage = null,

    /// The Amazon Resource Name (ARN) of the execution role that Batch can assume.
    /// For more information,
    /// see [Batch execution IAM
    /// role](https://docs.aws.amazon.com/batch/latest/userguide/execution-IAM-role.html) in the *Batch User Guide*.
    execution_role_arn: ?[]const u8 = null,

    /// The exit code returned upon completion.
    exit_code: ?i32 = null,

    /// The platform configuration for jobs that are running on Fargate resources.
    /// Jobs that are
    /// running on Amazon EC2 resources must not specify this parameter.
    fargate_platform_configuration: ?FargatePlatformConfiguration = null,

    /// The image used to start the container.
    image: ?[]const u8 = null,

    /// The instance type of the underlying host infrastructure of a multi-node
    /// parallel job.
    ///
    /// This parameter isn't applicable to jobs that are running on Fargate
    /// resources.
    instance_type: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) that's associated with the job when run.
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
    /// driver that the Docker daemon uses. However, the container might use a
    /// different logging driver
    /// than the Docker daemon by specifying a log driver with this parameter in the
    /// container
    /// definition. To use a different logging driver for a container, the log
    /// system must be configured
    /// properly on the container instance. Or, alternatively, it must be configured
    /// on a different log
    /// server for remote logging options. For more information on the options for
    /// different supported
    /// log drivers, see [Configure
    /// logging drivers](https://docs.docker.com/engine/admin/logging/overview/) in
    /// the Docker documentation.
    ///
    /// Batch currently supports a subset of the logging drivers available to the
    /// Docker daemon
    /// (shown in the
    /// [LogConfiguration](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-batch-jobdefinition-containerproperties-logconfiguration.html) data type). Additional log drivers might be available in future
    /// releases of the Amazon ECS container agent.
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

    /// The name of the Amazon CloudWatch Logs log stream that's associated with the
    /// container. The log group for
    /// Batch jobs is `/aws/batch/job`. Each container attempt receives a log stream
    /// name
    /// when they reach the `RUNNING` status.
    log_stream_name: ?[]const u8 = null,

    /// For jobs running on Amazon EC2 resources that didn't specify memory
    /// requirements using
    /// `resourceRequirements`, the number of MiB of memory reserved for the job.
    /// For other
    /// jobs, including all run on Fargate resources, see `resourceRequirements`.
    memory: ?i32 = null,

    /// The mount points for data volumes in your container.
    mount_points: ?[]const MountPoint = null,

    /// The network configuration for jobs that are running on Fargate resources.
    /// Jobs that are
    /// running on Amazon EC2 resources must not specify this parameter.
    network_configuration: ?NetworkConfiguration = null,

    /// The network interfaces that are associated with the job.
    network_interfaces: ?[]const NetworkInterface = null,

    /// When this parameter is true, the container is given elevated permissions on
    /// the host
    /// container instance (similar to the `root` user). The default value is
    /// `false`.
    ///
    /// This parameter isn't applicable to jobs that are running on Fargate
    /// resources and
    /// shouldn't be provided, or specified as `false`.
    privileged: ?bool = null,

    /// When this parameter is true, the container is given read-only access to its
    /// root file
    /// system. This parameter maps to `ReadonlyRootfs` in the
    /// [Create a
    /// container](https://docs.docker.com/engine/api/v1.23/#create-a-container)
    /// section of the [Docker Remote
    /// API](https://docs.docker.com/engine/api/v1.23/) and the
    /// `--read-only` option to [
    /// `docker
    /// run`
    /// ](https://docs.docker.com/engine/reference/commandline/run/).
    readonly_root_filesystem: ?bool = null,

    /// A short (255 max characters) human-readable string to provide additional
    /// details for a
    /// running or stopped container.
    reason: ?[]const u8 = null,

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

    /// The secrets to pass to the container. For more information, see [Specifying
    /// sensitive
    /// data](https://docs.aws.amazon.com/batch/latest/userguide/specifying-sensitive-data.html) in the
    /// *Batch User Guide*.
    secrets: ?[]const Secret = null,

    /// The Amazon Resource Name (ARN) of the Amazon ECS task that's associated with
    /// the container job. Each container
    /// attempt receives a task ARN when they reach the `STARTING` status.
    task_arn: ?[]const u8 = null,

    /// A list of `ulimit` values to set in the container. This parameter maps to
    /// `Ulimits` in the [Create a
    /// container](https://docs.docker.com/engine/api/v1.23/#create-a-container)
    /// section of the [Docker Remote
    /// API](https://docs.docker.com/engine/api/v1.23/)
    /// and the `--ulimit` option to [docker
    /// run](https://docs.docker.com/engine/reference/run/).
    ///
    /// This parameter isn't applicable to jobs that are running on Fargate
    /// resources.
    ulimits: ?[]const Ulimit = null,

    /// The user name to use inside the container. This parameter maps to `User` in
    /// the
    /// [Create a
    /// container](https://docs.docker.com/engine/api/v1.23/#create-a-container)
    /// section of the [Docker Remote
    /// API](https://docs.docker.com/engine/api/v1.23/) and the `--user`
    /// option to [docker run](https://docs.docker.com/engine/reference/run/).
    user: ?[]const u8 = null,

    /// The number of vCPUs reserved for the container. For jobs that run on Amazon
    /// EC2 resources, you
    /// can specify the vCPU requirement for the job using `resourceRequirements`,
    /// but you
    /// can't specify the vCPU requirements in both the `vcpus` and
    /// `resourceRequirements` object. This parameter maps to `CpuShares` in the
    /// [Create a
    /// container](https://docs.docker.com/engine/api/v1.23/#create-a-container)
    /// section of the [Docker Remote
    /// API](https://docs.docker.com/engine/api/v1.23/) and the
    /// `--cpu-shares` option to [docker
    /// run](https://docs.docker.com/engine/reference/run/). Each
    /// vCPU is equivalent to 1,024 CPU shares. You must specify at least one vCPU.
    /// This is required but
    /// can be specified in several places. It must be specified for each node at
    /// least once.
    ///
    /// This parameter isn't applicable to jobs that run on Fargate resources. For
    /// jobs that run
    /// on Fargate resources, you must specify the vCPU requirement for the job
    /// using
    /// `resourceRequirements`.
    vcpus: ?i32 = null,

    /// A list of volumes that are associated with the job.
    volumes: ?[]const Volume = null,

    pub const json_field_names = .{
        .command = "command",
        .container_instance_arn = "containerInstanceArn",
        .enable_execute_command = "enableExecuteCommand",
        .environment = "environment",
        .ephemeral_storage = "ephemeralStorage",
        .execution_role_arn = "executionRoleArn",
        .exit_code = "exitCode",
        .fargate_platform_configuration = "fargatePlatformConfiguration",
        .image = "image",
        .instance_type = "instanceType",
        .job_role_arn = "jobRoleArn",
        .linux_parameters = "linuxParameters",
        .log_configuration = "logConfiguration",
        .log_stream_name = "logStreamName",
        .memory = "memory",
        .mount_points = "mountPoints",
        .network_configuration = "networkConfiguration",
        .network_interfaces = "networkInterfaces",
        .privileged = "privileged",
        .readonly_root_filesystem = "readonlyRootFilesystem",
        .reason = "reason",
        .repository_credentials = "repositoryCredentials",
        .resource_requirements = "resourceRequirements",
        .runtime_platform = "runtimePlatform",
        .secrets = "secrets",
        .task_arn = "taskArn",
        .ulimits = "ulimits",
        .user = "user",
        .vcpus = "vcpus",
        .volumes = "volumes",
    };
};
