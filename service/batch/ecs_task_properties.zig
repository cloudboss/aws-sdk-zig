const TaskContainerProperties = @import("task_container_properties.zig").TaskContainerProperties;
const EphemeralStorage = @import("ephemeral_storage.zig").EphemeralStorage;
const NetworkConfiguration = @import("network_configuration.zig").NetworkConfiguration;
const RuntimePlatform = @import("runtime_platform.zig").RuntimePlatform;
const Volume = @import("volume.zig").Volume;

/// The properties for a task definition that describes the container and volume
/// definitions of
/// an Amazon ECS task. You can specify which Docker images to use, the required
/// resources, and other
/// configurations related to launching the task definition through an Amazon
/// ECS service or task.
pub const EcsTaskProperties = struct {
    /// This object is a list of containers.
    containers: []const TaskContainerProperties,

    /// Determines whether execute command functionality is turned on for this task.
    /// If `true`, execute
    /// command functionality is turned on all the containers in the task.
    enable_execute_command: ?bool = null,

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

    /// The IPC resource namespace to use for the containers in the task. The valid
    /// values are
    /// `host`, `task`, or `none`.
    ///
    /// If `host` is specified, all containers within the tasks that specified the
    /// `host` IPC mode on the same container instance share the same IPC resources
    /// with the
    /// host Amazon EC2 instance.
    ///
    /// If `task` is specified, all containers within the specified `task`
    /// share the same IPC resources.
    ///
    /// If `none` is specified, the IPC resources within the containers of a task
    /// are
    /// private, and are not shared with other containers in a task or on the
    /// container instance.
    ///
    /// If no value is specified, then the IPC resource namespace sharing depends on
    /// the Docker
    /// daemon setting on the container instance. For more information, see [IPC
    /// settings](https://docs.docker.com/engine/reference/run/#ipc-settings---ipc)
    /// in
    /// the Docker run reference.
    ipc_mode: ?[]const u8 = null,

    /// The network configuration for jobs that are running on Fargate resources.
    /// Jobs that are
    /// running on Amazon EC2 resources must not specify this parameter.
    network_configuration: ?NetworkConfiguration = null,

    /// The process namespace to use for the containers in the task. The valid
    /// values are
    /// `host` or `task`. For example, monitoring sidecars might need
    /// `pidMode` to access information about other containers running in the same
    /// task.
    ///
    /// If `host` is specified, all containers within the tasks that specified the
    /// `host` PID mode on the same container instance share the process namespace
    /// with the
    /// host Amazon EC2 instance.
    ///
    /// If `task` is specified, all containers within the specified task share the
    /// same
    /// process namespace.
    ///
    /// If no value is specified, the default is a private namespace for each
    /// container. For more
    /// information, see [PID
    /// settings](https://docs.docker.com/engine/reference/run/#pid-settings---pid)
    /// in the Docker run reference.
    pid_mode: ?[]const u8 = null,

    /// The Fargate platform version where the jobs are running. A platform version
    /// is specified
    /// only for jobs that are running on Fargate resources. If one isn't specified,
    /// the
    /// `LATEST` platform version is used by default. This uses a recent, approved
    /// version of
    /// the Fargate platform for compute resources. For more information, see
    /// [Fargate
    /// platform
    /// versions](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/platform_versions.html) in the *Amazon Elastic Container Service Developer Guide*.
    platform_version: ?[]const u8 = null,

    /// An object that represents the compute environment architecture for Batch
    /// jobs on
    /// Fargate.
    runtime_platform: ?RuntimePlatform = null,

    /// The Amazon Resource Name (ARN) that's associated with the Amazon ECS task.
    ///
    /// This is object is comparable to
    /// [ContainerProperties:jobRoleArn](https://docs.aws.amazon.com/batch/latest/APIReference/API_ContainerProperties.html).
    task_role_arn: ?[]const u8 = null,

    /// A list of volumes that are associated with the job.
    volumes: ?[]const Volume = null,

    pub const json_field_names = .{
        .containers = "containers",
        .enable_execute_command = "enableExecuteCommand",
        .ephemeral_storage = "ephemeralStorage",
        .execution_role_arn = "executionRoleArn",
        .ipc_mode = "ipcMode",
        .network_configuration = "networkConfiguration",
        .pid_mode = "pidMode",
        .platform_version = "platformVersion",
        .runtime_platform = "runtimePlatform",
        .task_role_arn = "taskRoleArn",
        .volumes = "volumes",
    };
};
