const ResultStatus = @import("result_status.zig").ResultStatus;
const TaskError = @import("task_error.zig").TaskError;

/// Contains information about a user's access to an application.
pub const UserAccessResultItem = struct {
    /// The name of the application.
    app: ?[]const u8,

    /// The email address of the target user.
    email: ?[]const u8,

    /// The status of the user access result item.
    ///
    /// The following states are possible:
    ///
    /// * `IN_PROGRESS`: The user access task is in progress.
    ///
    /// * `COMPLETED`: The user access task completed successfully.
    ///
    /// * `FAILED`: The user access task failed.
    ///
    /// * `EXPIRED`: The user access task expired.
    result_status: ?ResultStatus,

    /// Contains information about an error returned from a user access task.
    task_error: ?TaskError,

    /// The unique ID of the task.
    task_id: ?[]const u8,

    /// The display name of the tenant.
    tenant_display_name: ?[]const u8,

    /// The ID of the application tenant.
    tenant_id: ?[]const u8,

    /// The first name of the user.
    user_first_name: ?[]const u8,

    /// The full name of the user.
    user_full_name: ?[]const u8,

    /// The unique ID of user.
    user_id: ?[]const u8,

    /// The last name of the user.
    user_last_name: ?[]const u8,

    /// The status of the user returned by the application.
    user_status: ?[]const u8,

    pub const json_field_names = .{
        .app = "app",
        .email = "email",
        .result_status = "resultStatus",
        .task_error = "taskError",
        .task_id = "taskId",
        .tenant_display_name = "tenantDisplayName",
        .tenant_id = "tenantId",
        .user_first_name = "userFirstName",
        .user_full_name = "userFullName",
        .user_id = "userId",
        .user_last_name = "userLastName",
        .user_status = "userStatus",
    };
};
