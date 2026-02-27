const OtaTaskExecutionStatus = @import("ota_task_execution_status.zig").OtaTaskExecutionStatus;

/// Structure representing one over-the-air (OTA) task execution summary.
pub const OtaTaskExecutionSummary = struct {
    /// The execution number of the over-the-air (OTA) task execution summary.
    execution_number: ?i64,

    /// The timestamp value of when the over-the-air (OTA) task execution summary
    /// was last updated.
    last_updated_at: ?i64,

    /// The timestamp value of when the over-the-air (OTA) task execution summary is
    /// targeted to start.
    queued_at: ?i64,

    /// The number of retry attempts for starting the over-the-air (OTA) task
    /// execution summary after a failed attempt.
    retry_attempt: ?i32,

    /// The timestamp value of when the over-the-air (OTA) task execution summary
    /// started.
    started_at: ?i64,

    /// The status of the over-the-air (OTA) task execution summary.
    status: ?OtaTaskExecutionStatus,

    pub const json_field_names = .{
        .execution_number = "ExecutionNumber",
        .last_updated_at = "LastUpdatedAt",
        .queued_at = "QueuedAt",
        .retry_attempt = "RetryAttempt",
        .started_at = "StartedAt",
        .status = "Status",
    };
};
