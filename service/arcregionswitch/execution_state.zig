pub const ExecutionState = enum {
    in_progress,
    paused_by_failed_step,
    paused_by_operator,
    completed,
    completed_with_exceptions,
    cancelled,
    plan_execution_timed_out,
    pending_manual_approval,
    failed,
    pending,
    completed_monitoring_application_health,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .paused_by_failed_step = "PAUSED_BY_FAILED_STEP",
        .paused_by_operator = "PAUSED_BY_OPERATOR",
        .completed = "COMPLETED",
        .completed_with_exceptions = "COMPLETED_WITH_EXCEPTIONS",
        .cancelled = "CANCELLED",
        .plan_execution_timed_out = "PLAN_EXECUTION_TIMED_OUT",
        .pending_manual_approval = "PENDING_MANUAL_APPROVAL",
        .failed = "FAILED",
        .pending = "PENDING",
        .completed_monitoring_application_health = "COMPLETED_MONITORING_APPLICATION_HEALTH",
    };
};
