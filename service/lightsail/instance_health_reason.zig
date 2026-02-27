pub const InstanceHealthReason = enum {
    lb_registration_in_progress,
    lb_initial_health_checking,
    lb_internal_error,
    instance_response_code_mismatch,
    instance_timeout,
    instance_failed_health_checks,
    instance_not_registered,
    instance_not_in_use,
    instance_deregistration_in_progress,
    instance_invalid_state,
    instance_ip_unusable,

    pub const json_field_names = .{
        .lb_registration_in_progress = "LbRegistrationInProgress",
        .lb_initial_health_checking = "LbInitialHealthChecking",
        .lb_internal_error = "LbInternalError",
        .instance_response_code_mismatch = "InstanceResponseCodeMismatch",
        .instance_timeout = "InstanceTimeout",
        .instance_failed_health_checks = "InstanceFailedHealthChecks",
        .instance_not_registered = "InstanceNotRegistered",
        .instance_not_in_use = "InstanceNotInUse",
        .instance_deregistration_in_progress = "InstanceDeregistrationInProgress",
        .instance_invalid_state = "InstanceInvalidState",
        .instance_ip_unusable = "InstanceIpUnusable",
    };
};
