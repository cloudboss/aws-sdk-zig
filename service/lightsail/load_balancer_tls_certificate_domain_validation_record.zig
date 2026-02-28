const LoadBalancerTlsCertificateDnsRecordCreationState = @import("load_balancer_tls_certificate_dns_record_creation_state.zig").LoadBalancerTlsCertificateDnsRecordCreationState;
const LoadBalancerTlsCertificateDomainStatus = @import("load_balancer_tls_certificate_domain_status.zig").LoadBalancerTlsCertificateDomainStatus;

/// Describes the validation record of each domain name in the SSL/TLS
/// certificate.
pub const LoadBalancerTlsCertificateDomainValidationRecord = struct {
    /// An object that describes the state of the canonical name (CNAME) records
    /// that are
    /// automatically added by Lightsail to the DNS of a domain to validate domain
    /// ownership.
    dns_record_creation_state: ?LoadBalancerTlsCertificateDnsRecordCreationState,

    /// The domain name against which your SSL/TLS certificate was validated.
    domain_name: ?[]const u8,

    /// A fully qualified domain name in the certificate. For example,
    /// `example.com`.
    name: ?[]const u8,

    /// The type of validation record. For example, `CNAME` for domain
    /// validation.
    @"type": ?[]const u8,

    /// The validation status. Valid values are listed below.
    validation_status: ?LoadBalancerTlsCertificateDomainStatus,

    /// The value for that type.
    value: ?[]const u8,

    pub const json_field_names = .{
        .dns_record_creation_state = "dnsRecordCreationState",
        .domain_name = "domainName",
        .name = "name",
        .@"type" = "type",
        .validation_status = "validationStatus",
        .value = "value",
    };
};
