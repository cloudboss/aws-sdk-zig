const TaskError = @import("task_error.zig").TaskError;

/// Contains information about a user access task.
pub const UserAccessTaskItem = struct {
    /// The name of the application.
    app: []const u8,

    /// Error from the task, if any.
    @"error": ?TaskError,

    /// The unique ID of the task.
    task_id: ?[]const u8,

    /// The ID of the application tenant.
    tenant_id: []const u8,

    pub const json_field_names = .{
        .app = "app",
        .@"error" = "error",
        .task_id = "taskId",
        .tenant_id = "tenantId",
    };
};
