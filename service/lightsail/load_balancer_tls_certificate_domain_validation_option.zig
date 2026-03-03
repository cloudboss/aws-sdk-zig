const LoadBalancerTlsCertificateDomainStatus = @import("load_balancer_tls_certificate_domain_status.zig").LoadBalancerTlsCertificateDomainStatus;

/// Contains information about the domain names on an SSL/TLS certificate that
/// you will use to
/// validate domain ownership.
pub const LoadBalancerTlsCertificateDomainValidationOption = struct {
    /// The fully qualified domain name in the certificate request.
    domain_name: ?[]const u8 = null,

    /// The status of the domain validation. Valid values are listed below.
    validation_status: ?LoadBalancerTlsCertificateDomainStatus = null,

    pub const json_field_names = .{
        .domain_name = "domainName",
        .validation_status = "validationStatus",
    };
};
