const AuditMitigationActionsTaskStatus = @import("audit_mitigation_actions_task_status.zig").AuditMitigationActionsTaskStatus;

/// Information about an audit mitigation actions task that is returned by
/// `ListAuditMitigationActionsTasks`.
pub const AuditMitigationActionsTaskMetadata = struct {
    /// The time at which the audit mitigation actions task was started.
    start_time: ?i64 = null,

    /// The unique identifier for the task.
    task_id: ?[]const u8 = null,

    /// The current state of the audit mitigation actions task.
    task_status: ?AuditMitigationActionsTaskStatus = null,

    pub const json_field_names = .{
        .start_time = "startTime",
        .task_id = "taskId",
        .task_status = "taskStatus",
    };
};
