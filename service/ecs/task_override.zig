const ContainerOverride = @import("container_override.zig").ContainerOverride;
const EphemeralStorage = @import("ephemeral_storage.zig").EphemeralStorage;
const InferenceAcceleratorOverride = @import("inference_accelerator_override.zig").InferenceAcceleratorOverride;

/// The overrides that are associated with a task.
pub const TaskOverride = struct {
    /// One or more container overrides that are sent to a task.
    container_overrides: ?[]const ContainerOverride = null,

    /// The CPU override for the task.
    cpu: ?[]const u8 = null,

    /// The ephemeral storage setting override for the task.
    ///
    /// This parameter is only supported for tasks hosted on Fargate that use the
    /// following platform versions:
    ///
    /// * Linux platform version `1.4.0` or later.
    /// * Windows platform version `1.0.0` or later.
    ephemeral_storage: ?EphemeralStorage = null,

    /// The Amazon Resource Name (ARN) of the task execution role override for the
    /// task. For more information, see [Amazon ECS task execution IAM
    /// role](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_execution_IAM_role.html) in the *Amazon Elastic Container Service Developer Guide*.
    execution_role_arn: ?[]const u8 = null,

    /// The Elastic Inference accelerator override for the task.
    inference_accelerator_overrides: ?[]const InferenceAcceleratorOverride = null,

    /// The memory override for the task.
    memory: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the role that containers in this task can
    /// assume. All containers in this task are granted the permissions that are
    /// specified in this role. For more information, see [IAM Role for
    /// Tasks](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-iam-roles.html) in the *Amazon Elastic Container Service Developer Guide*.
    task_role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .container_overrides = "containerOverrides",
        .cpu = "cpu",
        .ephemeral_storage = "ephemeralStorage",
        .execution_role_arn = "executionRoleArn",
        .inference_accelerator_overrides = "inferenceAcceleratorOverrides",
        .memory = "memory",
        .task_role_arn = "taskRoleArn",
    };
};
