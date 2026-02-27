const AuditTaskStatus = @import("audit_task_status.zig").AuditTaskStatus;
const AuditTaskType = @import("audit_task_type.zig").AuditTaskType;

/// The audits that were performed.
pub const AuditTaskMetadata = struct {
    /// The ID of this audit.
    task_id: ?[]const u8,

    /// The status of this audit. One of "IN_PROGRESS", "COMPLETED",
    /// "FAILED", or "CANCELED".
    task_status: ?AuditTaskStatus,

    /// The type of this audit. One of "ON_DEMAND_AUDIT_TASK" or
    /// "SCHEDULED_AUDIT_TASK".
    task_type: ?AuditTaskType,

    pub const json_field_names = .{
        .task_id = "taskId",
        .task_status = "taskStatus",
        .task_type = "taskType",
    };
};
