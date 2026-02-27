const TaskContainerDetails = @import("task_container_details.zig").TaskContainerDetails;
const EphemeralStorage = @import("ephemeral_storage.zig").EphemeralStorage;
const NetworkConfiguration = @import("network_configuration.zig").NetworkConfiguration;
const RuntimePlatform = @import("runtime_platform.zig").RuntimePlatform;
const Volume = @import("volume.zig").Volume;

/// The details of a task definition that describes the container and volume
/// definitions of an
/// Amazon ECS task.
pub const EcsTaskDetails = struct {
    /// The Amazon Resource Name (ARN) of the container instance that hosts the
    /// task.
    container_instance_arn: ?[]const u8,

    /// A list of containers that are included in the `taskProperties` list.
    containers: ?[]const TaskContainerDetails,

    /// Determines whether execute command functionality is turned on for this task.
    /// If `true`, execute
    /// command functionality is turned on all the containers in the task.
    enable_execute_command: ?bool,

    /// The amount of ephemeral storage allocated for the task.
    ephemeral_storage: ?EphemeralStorage,

    /// The Amazon Resource Name (ARN) of the execution role that Batch can assume.
    /// For more information, see
    /// [Batch execution IAM
    /// role](https://docs.aws.amazon.com/batch/latest/userguide/execution-IAM-role.html) in the *Batch User Guide*.
    execution_role_arn: ?[]const u8,

    /// The IPC resource namespace to use for the containers in the task. The valid
    /// values are
    /// `host`, `task`, or `none`. For more information see `ipcMode` in
    /// [EcsTaskProperties](https://docs.aws.amazon.com/batch/latest/APIReference/API_EcsTaskProperties.html).
    ipc_mode: ?[]const u8,

    /// The network configuration for jobs that are running on Fargate resources.
    /// Jobs that are
    /// running on Amazon EC2 resources must not specify this parameter.
    network_configuration: ?NetworkConfiguration,

    /// The process namespace to use for the containers in the task. The valid
    /// values are
    /// `host`, or `task`. For more information see `pidMode` in
    /// [EcsTaskProperties](https://docs.aws.amazon.com/batch/latest/APIReference/API_EcsTaskProperties.html).
    pid_mode: ?[]const u8,

    /// The Fargate platform version where the jobs are running.
    platform_version: ?[]const u8,

    /// An object that represents the compute environment architecture for Batch
    /// jobs on
    /// Fargate.
    runtime_platform: ?RuntimePlatform,

    /// The ARN of the Amazon ECS task.
    task_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the IAM role that the container can assume
    /// for Amazon Web Services permissions. For more
    /// information, see [IAM roles for
    /// tasks](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-iam-roles.html) in the
    /// *Amazon Elastic Container Service Developer Guide*.
    ///
    /// This is object is comparable to
    /// [ContainerProperties:jobRoleArn](https://docs.aws.amazon.com/batch/latest/APIReference/API_ContainerProperties.html).
    task_role_arn: ?[]const u8,

    /// A list of data volumes used in a job.
    volumes: ?[]const Volume,

    pub const json_field_names = .{
        .container_instance_arn = "containerInstanceArn",
        .containers = "containers",
        .enable_execute_command = "enableExecuteCommand",
        .ephemeral_storage = "ephemeralStorage",
        .execution_role_arn = "executionRoleArn",
        .ipc_mode = "ipcMode",
        .network_configuration = "networkConfiguration",
        .pid_mode = "pidMode",
        .platform_version = "platformVersion",
        .runtime_platform = "runtimePlatform",
        .task_arn = "taskArn",
        .task_role_arn = "taskRoleArn",
        .volumes = "volumes",
    };
};
