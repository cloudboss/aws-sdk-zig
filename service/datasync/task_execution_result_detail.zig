const PhaseStatus = @import("phase_status.zig").PhaseStatus;

/// Provides detailed information about the result of your DataSync task
/// execution.
pub const TaskExecutionResultDetail = struct {
    /// An error that DataSync encountered during your task execution. You can use
    /// this information to help [troubleshoot
    /// issues](https://docs.aws.amazon.com/datasync/latest/userguide/troubleshooting-datasync-locations-tasks.html).
    error_code: ?[]const u8,

    /// The detailed description of an error that DataSync encountered during your
    /// task execution. You can use this information to help [troubleshoot
    /// issues](https://docs.aws.amazon.com/datasync/latest/userguide/troubleshooting-datasync-locations-tasks.html).
    error_detail: ?[]const u8,

    /// The time in milliseconds that your task execution was in the `PREPARING`
    /// step. For more information, see [Task
    /// execution
    /// statuses](https://docs.aws.amazon.com/datasync/latest/userguide/run-task.html#understand-task-execution-statuses).
    ///
    /// For Enhanced mode tasks, the value is always `0`. For more information, see
    /// [How DataSync prepares your data
    /// transfer](https://docs.aws.amazon.com/datasync/latest/userguide/how-datasync-transfer-works.html#how-datasync-prepares).
    prepare_duration: ?i64,

    /// The status of the `PREPARING` step for your task execution. For more
    /// information, see [Task
    /// execution
    /// statuses](https://docs.aws.amazon.com/datasync/latest/userguide/run-task.html#understand-task-execution-statuses).
    prepare_status: ?PhaseStatus,

    /// The time in milliseconds that your task execution ran.
    total_duration: ?i64,

    /// The time in milliseconds that your task execution was in the `TRANSFERRING`
    /// step. For more information, see [Task
    /// execution
    /// statuses](https://docs.aws.amazon.com/datasync/latest/userguide/run-task.html#understand-task-execution-statuses).
    ///
    /// For Enhanced mode tasks, the value is always `0`. For more information, see
    /// [How DataSync transfers your
    /// data](https://docs.aws.amazon.com/datasync/latest/userguide/how-datasync-transfer-works.html#how-datasync-transfers).
    transfer_duration: ?i64,

    /// The status of the `TRANSFERRING` step for your task execution. For more
    /// information, see [Task
    /// execution
    /// statuses](https://docs.aws.amazon.com/datasync/latest/userguide/run-task.html#understand-task-execution-statuses).
    transfer_status: ?PhaseStatus,

    /// The time in milliseconds that your task execution was in the `VERIFYING`
    /// step. For more information, see [Task
    /// execution
    /// statuses](https://docs.aws.amazon.com/datasync/latest/userguide/run-task.html#understand-task-execution-statuses).
    ///
    /// For Enhanced mode tasks, the value is always `0`. For more information, see
    /// [How DataSync verifies your data's
    /// integrity](https://docs.aws.amazon.com/datasync/latest/userguide/how-datasync-transfer-works.html#how-verifying-works).
    verify_duration: ?i64,

    /// The status of the `VERIFYING` step for your task execution. For more
    /// information, see [Task
    /// execution
    /// statuses](https://docs.aws.amazon.com/datasync/latest/userguide/run-task.html#understand-task-execution-statuses).
    verify_status: ?PhaseStatus,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_detail = "ErrorDetail",
        .prepare_duration = "PrepareDuration",
        .prepare_status = "PrepareStatus",
        .total_duration = "TotalDuration",
        .transfer_duration = "TransferDuration",
        .transfer_status = "TransferStatus",
        .verify_duration = "VerifyDuration",
        .verify_status = "VerifyStatus",
    };
};
