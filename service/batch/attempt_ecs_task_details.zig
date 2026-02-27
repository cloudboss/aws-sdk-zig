const AttemptTaskContainerDetails = @import("attempt_task_container_details.zig").AttemptTaskContainerDetails;

/// An object that represents the details of a task.
pub const AttemptEcsTaskDetails = struct {
    /// The Amazon Resource Name (ARN) of the container instance that hosts the
    /// task.
    container_instance_arn: ?[]const u8,

    /// A list of containers that are included in the `taskProperties` list.
    containers: ?[]const AttemptTaskContainerDetails,

    /// The ARN of the Amazon ECS task.
    task_arn: ?[]const u8,

    pub const json_field_names = .{
        .container_instance_arn = "containerInstanceArn",
        .containers = "containers",
        .task_arn = "taskArn",
    };
};
