const ResourceStatus = @import("resource_status.zig").ResourceStatus;

/// Contains summary information about a task.
pub const TaskSummary = struct {
    /// The time the task was created, in Unix epoch time.
    created_at: i64,

    /// The description of the task.
    description: ?[]const u8 = null,

    /// The current lifecycle status of the task.
    status: ResourceStatus,

    /// The ARN of the task.
    task_arn: []const u8,

    /// The name of the task.
    task_name: []const u8,

    /// The time the task was last updated, in Unix epoch time.
    updated_at: i64,

    /// The version of the task.
    version: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .status = "status",
        .task_arn = "taskArn",
        .task_name = "taskName",
        .updated_at = "updatedAt",
        .version = "version",
    };
};
