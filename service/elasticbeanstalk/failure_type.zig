pub const FailureType = enum {
    update_cancelled,
    cancellation_failed,
    rollback_failed,
    rollback_successful,
    internal_failure,
    invalid_environment_state,
    permissions_error,
};
