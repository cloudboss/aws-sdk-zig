const EcsLaunchType = @import("ecs_launch_type.zig").EcsLaunchType;

/// Contains information about Amazon ECS task involved in a GuardDuty finding,
/// including task definition and container identifiers.
pub const EcsTask = struct {
    /// A list of unique identifiers for the containers associated with the Amazon
    /// ECS task.
    container_uids: ?[]const []const u8,

    /// The timestamp indicating when the Amazon ECS task was created, in UTC
    /// format.
    created_at: ?i64,

    /// The infrastructure type on which the Amazon ECS task runs.
    launch_type: ?EcsLaunchType,

    /// The ARN of task definition which describes the container and volume
    /// definitions of the Amazon ECS task.
    task_definition_arn: ?[]const u8,

    pub const json_field_names = .{
        .container_uids = "ContainerUids",
        .created_at = "CreatedAt",
        .launch_type = "LaunchType",
        .task_definition_arn = "TaskDefinitionArn",
    };
};
