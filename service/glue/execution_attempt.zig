const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;

/// A run attempt for a column statistics task run.
pub const ExecutionAttempt = struct {
    /// A task run ID for the last column statistics task run.
    column_statistics_task_run_id: ?[]const u8 = null,

    /// An error message associated with the last column statistics task run.
    error_message: ?[]const u8 = null,

    /// A timestamp when the last column statistics task run occurred.
    execution_timestamp: ?i64 = null,

    /// The status of the last column statistics task run.
    status: ?ExecutionStatus = null,

    pub const json_field_names = .{
        .column_statistics_task_run_id = "ColumnStatisticsTaskRunId",
        .error_message = "ErrorMessage",
        .execution_timestamp = "ExecutionTimestamp",
        .status = "Status",
    };
};
