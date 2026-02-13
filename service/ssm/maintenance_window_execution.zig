const MaintenanceWindowExecutionStatus = @import("maintenance_window_execution_status.zig").MaintenanceWindowExecutionStatus;

/// Describes the information about an execution of a maintenance window.
pub const MaintenanceWindowExecution = struct {
    /// The time the execution finished.
    end_time: ?i64,

    /// The time the execution started.
    start_time: ?i64,

    /// The status of the execution.
    status: ?MaintenanceWindowExecutionStatus,

    /// The details explaining the status. Not available for all status values.
    status_details: ?[]const u8,

    /// The ID of the maintenance window execution.
    window_execution_id: ?[]const u8,

    /// The ID of the maintenance window.
    window_id: ?[]const u8,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .start_time = "StartTime",
        .status = "Status",
        .status_details = "StatusDetails",
        .window_execution_id = "WindowExecutionId",
        .window_id = "WindowId",
    };
};
