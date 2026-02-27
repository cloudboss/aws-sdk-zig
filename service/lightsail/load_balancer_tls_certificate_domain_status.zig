pub const LoadBalancerTlsCertificateDomainStatus = enum {
    pending_validation,
    failed,
    success,

    pub const json_field_names = .{
        .pending_validation = "PendingValidation",
        .failed = "Failed",
        .success = "Success",
    };
};
