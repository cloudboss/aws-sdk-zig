pub const AcceleratedRecoveryStatus = enum {
    enabling,
    enable_failed,
    enabling_hosted_zone_locked,
    enabled,
    disabling,
    disable_failed,
    disabled,
    disabling_hosted_zone_locked,
};
