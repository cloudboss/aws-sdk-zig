pub const LoadBalancerTlsCertificateRenewalStatus = enum {
    pending_auto_renewal,
    pending_validation,
    success,
    failed,

    pub const json_field_names = .{
        .pending_auto_renewal = "PendingAutoRenewal",
        .pending_validation = "PendingValidation",
        .success = "Success",
        .failed = "Failed",
    };
};
