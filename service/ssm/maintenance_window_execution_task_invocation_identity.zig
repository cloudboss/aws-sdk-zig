const MaintenanceWindowExecutionStatus = @import("maintenance_window_execution_status.zig").MaintenanceWindowExecutionStatus;
const MaintenanceWindowTaskType = @import("maintenance_window_task_type.zig").MaintenanceWindowTaskType;

/// Describes the information about a task invocation for a particular target as
/// part of a task
/// execution performed as part of a maintenance window execution.
pub const MaintenanceWindowExecutionTaskInvocationIdentity = struct {
    /// The time the invocation finished.
    end_time: ?i64,

    /// The ID of the action performed in the service that actually handled the task
    /// invocation. If
    /// the task type is `RUN_COMMAND`, this value is the command ID.
    execution_id: ?[]const u8,

    /// The ID of the task invocation.
    invocation_id: ?[]const u8,

    /// User-provided value that was specified when the target was registered with
    /// the maintenance
    /// window. This was also included in any Amazon CloudWatch Events events raised
    /// during the task
    /// invocation.
    owner_information: ?[]const u8,

    /// The parameters that were provided for the invocation when it was run.
    parameters: ?[]const u8,

    /// The time the invocation started.
    start_time: ?i64,

    /// The status of the task invocation.
    status: ?MaintenanceWindowExecutionStatus,

    /// The details explaining the status of the task invocation. Not available for
    /// all status
    /// values.
    status_details: ?[]const u8,

    /// The ID of the specific task execution in the maintenance window execution.
    task_execution_id: ?[]const u8,

    /// The task type.
    task_type: ?MaintenanceWindowTaskType,

    /// The ID of the maintenance window execution that ran the task.
    window_execution_id: ?[]const u8,

    /// The ID of the target definition in this maintenance window the invocation
    /// was performed
    /// for.
    window_target_id: ?[]const u8,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .execution_id = "ExecutionId",
        .invocation_id = "InvocationId",
        .owner_information = "OwnerInformation",
        .parameters = "Parameters",
        .start_time = "StartTime",
        .status = "Status",
        .status_details = "StatusDetails",
        .task_execution_id = "TaskExecutionId",
        .task_type = "TaskType",
        .window_execution_id = "WindowExecutionId",
        .window_target_id = "WindowTargetId",
    };
};
