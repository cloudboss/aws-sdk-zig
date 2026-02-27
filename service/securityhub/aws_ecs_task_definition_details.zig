const AwsEcsTaskDefinitionContainerDefinitionsDetails = @import("aws_ecs_task_definition_container_definitions_details.zig").AwsEcsTaskDefinitionContainerDefinitionsDetails;
const AwsEcsTaskDefinitionInferenceAcceleratorsDetails = @import("aws_ecs_task_definition_inference_accelerators_details.zig").AwsEcsTaskDefinitionInferenceAcceleratorsDetails;
const AwsEcsTaskDefinitionPlacementConstraintsDetails = @import("aws_ecs_task_definition_placement_constraints_details.zig").AwsEcsTaskDefinitionPlacementConstraintsDetails;
const AwsEcsTaskDefinitionProxyConfigurationDetails = @import("aws_ecs_task_definition_proxy_configuration_details.zig").AwsEcsTaskDefinitionProxyConfigurationDetails;
const AwsEcsTaskDefinitionVolumesDetails = @import("aws_ecs_task_definition_volumes_details.zig").AwsEcsTaskDefinitionVolumesDetails;

/// Details about a task definition. A task definition describes the container
/// and volume definitions
/// of an Amazon Elastic Container Service task.
pub const AwsEcsTaskDefinitionDetails = struct {
    /// The container definitions that describe the containers that make up the
    /// task.
    container_definitions: ?[]const AwsEcsTaskDefinitionContainerDefinitionsDetails,

    /// The number of CPU units used by the task.Valid values are as follows:
    ///
    /// * `256 (.25 vCPU)`
    ///
    /// * `512 (.5 vCPU)`
    ///
    /// * `1024 (1 vCPU)`
    ///
    /// * `2048 (2 vCPU)`
    ///
    /// * `4096 (4 vCPU)`
    cpu: ?[]const u8,

    /// The ARN of the task execution role that grants the container agent
    /// permission to make API calls on behalf of the container user.
    execution_role_arn: ?[]const u8,

    /// The name of a family that this task definition is registered to.
    family: ?[]const u8,

    /// The Elastic Inference accelerators to use for the containers in the task.
    inference_accelerators: ?[]const AwsEcsTaskDefinitionInferenceAcceleratorsDetails,

    /// The inter-process communication (IPC) resource namespace to use for the
    /// containers in the task. Valid values are as follows:
    ///
    /// * `host`
    ///
    /// * `none`
    ///
    /// * `task`
    ipc_mode: ?[]const u8,

    /// The amount (in MiB) of memory used by the task.
    ///
    /// For tasks that are hosted on Amazon EC2, you can provide a task-level memory
    /// value or a container-level memory value.
    /// For tasks that are hosted on Fargate, you must use one of the [specified
    /// values](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size) in the *
    /// Amazon Elastic Container Service Developer Guide*
    /// , which determines your range of supported values for the `Cpu` and `Memory`
    /// parameters.
    memory: ?[]const u8,

    /// The Docker networking mode to use for the containers in the task. Valid
    /// values are as follows:
    ///
    /// * `awsvpc`
    ///
    /// * `bridge`
    ///
    /// * `host`
    ///
    /// * `none`
    network_mode: ?[]const u8,

    /// The process namespace to use for the containers in the task. Valid values
    /// are `host` or `task`.
    pid_mode: ?[]const u8,

    /// The placement constraint objects to use for tasks.
    placement_constraints: ?[]const AwsEcsTaskDefinitionPlacementConstraintsDetails,

    /// The configuration details for the App Mesh proxy.
    proxy_configuration: ?AwsEcsTaskDefinitionProxyConfigurationDetails,

    /// The task launch types that the task definition was validated against.
    requires_compatibilities: ?[]const []const u8,

    /// The status of the task definition.
    status: ?[]const u8,

    /// The short name or ARN of the IAM role that grants containers in the task
    /// permission to call Amazon Web Services API operations on your behalf.
    task_role_arn: ?[]const u8,

    /// The data volume definitions for the task.
    volumes: ?[]const AwsEcsTaskDefinitionVolumesDetails,

    pub const json_field_names = .{
        .container_definitions = "ContainerDefinitions",
        .cpu = "Cpu",
        .execution_role_arn = "ExecutionRoleArn",
        .family = "Family",
        .inference_accelerators = "InferenceAccelerators",
        .ipc_mode = "IpcMode",
        .memory = "Memory",
        .network_mode = "NetworkMode",
        .pid_mode = "PidMode",
        .placement_constraints = "PlacementConstraints",
        .proxy_configuration = "ProxyConfiguration",
        .requires_compatibilities = "RequiresCompatibilities",
        .status = "Status",
        .task_role_arn = "TaskRoleArn",
        .volumes = "Volumes",
    };
};
