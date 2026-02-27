pub const StackRefactorExecutionStatus = enum {
    unavailable,
    available,
    obsolete,
    execute_in_progress,
    execute_complete,
    execute_failed,
    rollback_in_progress,
    rollback_complete,
    rollback_failed,
};
