const EcsContainerOverride = @import("ecs_container_override.zig").EcsContainerOverride;
const EcsEphemeralStorage = @import("ecs_ephemeral_storage.zig").EcsEphemeralStorage;
const EcsInferenceAcceleratorOverride = @import("ecs_inference_accelerator_override.zig").EcsInferenceAcceleratorOverride;

/// The overrides that are associated with a task.
pub const EcsTaskOverride = struct {
    /// One or more container overrides that are sent to a task.
    container_overrides: ?[]const EcsContainerOverride = null,

    /// The cpu override for the task.
    cpu: ?[]const u8 = null,

    /// The ephemeral storage setting override for the task.
    ///
    /// This parameter is only supported for tasks hosted on Fargate that use
    /// the following platform versions:
    ///
    /// * Linux platform version `1.4.0` or later.
    ///
    /// * Windows platform version `1.0.0` or later.
    ephemeral_storage: ?EcsEphemeralStorage = null,

    /// The Amazon Resource Name (ARN) of the task execution IAM role override for
    /// the task. For
    /// more information, see [Amazon ECS
    /// task execution IAM
    /// role](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_execution_IAM_role.html) in the *Amazon Elastic Container Service Developer
    /// Guide*.
    execution_role_arn: ?[]const u8 = null,

    /// The Elastic Inference accelerator override for the task.
    inference_accelerator_overrides: ?[]const EcsInferenceAcceleratorOverride = null,

    /// The memory override for the task.
    memory: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role that containers in this task
    /// can assume.
    /// All containers in this task are granted the permissions that are specified
    /// in this role.
    /// For more information, see [IAM Role for
    /// Tasks](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-iam-roles.html) in
    /// the *Amazon Elastic Container Service Developer Guide*.
    task_role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .container_overrides = "ContainerOverrides",
        .cpu = "Cpu",
        .ephemeral_storage = "EphemeralStorage",
        .execution_role_arn = "ExecutionRoleArn",
        .inference_accelerator_overrides = "InferenceAcceleratorOverrides",
        .memory = "Memory",
        .task_role_arn = "TaskRoleArn",
    };
};
