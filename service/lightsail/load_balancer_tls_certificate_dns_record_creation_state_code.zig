pub const LoadBalancerTlsCertificateDnsRecordCreationStateCode = enum {
    succeeded,
    started,
    failed,

    pub const json_field_names = .{
        .succeeded = "Succeeded",
        .started = "Started",
        .failed = "Failed",
    };
};
