const aws = @import("aws");

const TaskState = @import("task_state.zig").TaskState;

/// Information about the task assigned to one or many devices.
pub const TaskSummary = struct {
    /// The state of the task assigned to one or many devices.
    state: ?TaskState,

    /// Optional metadata that you assign to a resource. You can use tags to
    /// categorize a resource
    /// in different ways, such as by purpose, owner, or environment.
    tags: ?[]const aws.map.StringMapEntry,

    /// The Amazon Resource Name (ARN) of the task.
    task_arn: ?[]const u8,

    /// The task ID.
    task_id: []const u8,

    pub const json_field_names = .{
        .state = "state",
        .tags = "tags",
        .task_arn = "taskArn",
        .task_id = "taskId",
    };
};
