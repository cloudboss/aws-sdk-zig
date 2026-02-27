pub const TargetHealthReasonEnum = enum {
    registration_in_progress,
    initial_health_checking,
    response_code_mismatch,
    timeout,
    failed_health_checks,
    not_registered,
    not_in_use,
    deregistration_in_progress,
    invalid_state,
    ip_unusable,
    health_check_disabled,
    internal_error,
};
