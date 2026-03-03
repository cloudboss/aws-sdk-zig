const AlarmConfiguration = @import("alarm_configuration.zig").AlarmConfiguration;
const MaintenanceWindowExecutionStatus = @import("maintenance_window_execution_status.zig").MaintenanceWindowExecutionStatus;
const MaintenanceWindowTaskType = @import("maintenance_window_task_type.zig").MaintenanceWindowTaskType;
const AlarmStateInformation = @import("alarm_state_information.zig").AlarmStateInformation;

/// Information about a task execution performed as part of a maintenance window
/// execution.
pub const MaintenanceWindowExecutionTaskIdentity = struct {
    /// The details for the CloudWatch alarm applied to your maintenance window
    /// task.
    alarm_configuration: ?AlarmConfiguration = null,

    /// The time the task execution finished.
    end_time: ?i64 = null,

    /// The time the task execution started.
    start_time: ?i64 = null,

    /// The status of the task execution.
    status: ?MaintenanceWindowExecutionStatus = null,

    /// The details explaining the status of the task execution. Not available for
    /// all status
    /// values.
    status_details: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the task that ran.
    task_arn: ?[]const u8 = null,

    /// The ID of the specific task execution in the maintenance window execution.
    task_execution_id: ?[]const u8 = null,

    /// The type of task that ran.
    task_type: ?MaintenanceWindowTaskType = null,

    /// The CloudWatch alarm that was invoked by the maintenance window task.
    triggered_alarms: ?[]const AlarmStateInformation = null,

    /// The ID of the maintenance window execution that ran the task.
    window_execution_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .alarm_configuration = "AlarmConfiguration",
        .end_time = "EndTime",
        .start_time = "StartTime",
        .status = "Status",
        .status_details = "StatusDetails",
        .task_arn = "TaskArn",
        .task_execution_id = "TaskExecutionId",
        .task_type = "TaskType",
        .triggered_alarms = "TriggeredAlarms",
        .window_execution_id = "WindowExecutionId",
    };
};
