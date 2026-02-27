pub const ReceivedStatus = enum {
    pending_workflow,
    pending_accept,
    rejected,
    active,
    failed_workflow,
    deleted,
    disabled,
    workflow_completed,

    pub const json_field_names = .{
        .pending_workflow = "PENDING_WORKFLOW",
        .pending_accept = "PENDING_ACCEPT",
        .rejected = "REJECTED",
        .active = "ACTIVE",
        .failed_workflow = "FAILED_WORKFLOW",
        .deleted = "DELETED",
        .disabled = "DISABLED",
        .workflow_completed = "WORKFLOW_COMPLETED",
    };
};
