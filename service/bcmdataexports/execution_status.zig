const ExecutionStatusCode = @import("execution_status_code.zig").ExecutionStatusCode;
const ExecutionStatusReason = @import("execution_status_reason.zig").ExecutionStatusReason;

/// The status of the execution.
pub const ExecutionStatus = struct {
    /// The time when the execution was completed.
    completed_at: ?i64,

    /// The time when the execution was created.
    created_at: ?i64,

    /// The time when the execution was last updated.
    last_updated_at: ?i64,

    /// The code for the status of the execution.
    status_code: ?ExecutionStatusCode,

    /// The reason for the failed status.
    status_reason: ?ExecutionStatusReason,

    pub const json_field_names = .{
        .completed_at = "CompletedAt",
        .created_at = "CreatedAt",
        .last_updated_at = "LastUpdatedAt",
        .status_code = "StatusCode",
        .status_reason = "StatusReason",
    };
};
