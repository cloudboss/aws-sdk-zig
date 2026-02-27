const DnsRecordCreationState = @import("dns_record_creation_state.zig").DnsRecordCreationState;
const ResourceRecord = @import("resource_record.zig").ResourceRecord;
const CertificateDomainValidationStatus = @import("certificate_domain_validation_status.zig").CertificateDomainValidationStatus;

/// Describes the domain name system (DNS) records that you must add to the DNS
/// of your
/// registered domain to validate ownership for an Amazon Lightsail SSL/TLS
/// certificate.
pub const DomainValidationRecord = struct {
    /// An object that describes the state of the canonical name (CNAME) records
    /// that are
    /// automatically added by Lightsail to the DNS of the domain to validate domain
    /// ownership.
    dns_record_creation_state: ?DnsRecordCreationState,

    /// The domain name of the certificate validation record. For example,
    /// `example.com` or `www.example.com`.
    domain_name: ?[]const u8,

    /// An object that describes the DNS records to add to your domain's DNS to
    /// validate it for
    /// the certificate.
    resource_record: ?ResourceRecord,

    /// The validation status of the record.
    validation_status: ?CertificateDomainValidationStatus,

    pub const json_field_names = .{
        .dns_record_creation_state = "dnsRecordCreationState",
        .domain_name = "domainName",
        .resource_record = "resourceRecord",
        .validation_status = "validationStatus",
    };
};
