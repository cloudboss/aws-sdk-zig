pub const InstanceRefreshStatus = enum {
    pending,
    in_progress,
    successful,
    failed,
    cancelling,
    cancelled,
    rollback_in_progress,
    rollback_failed,
    rollback_successful,
    baking,
};
