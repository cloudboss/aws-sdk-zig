const CertificateValidationRecord = @import("certificate_validation_record.zig").CertificateValidationRecord;
const CustomDomainAssociationStatus = @import("custom_domain_association_status.zig").CustomDomainAssociationStatus;

/// Describes a custom domain that's associated with an App Runner service.
pub const CustomDomain = struct {
    /// A list of certificate CNAME records that's used for this domain name.
    certificate_validation_records: ?[]const CertificateValidationRecord,

    /// An associated custom domain endpoint. It can be a root domain (for example,
    /// `example.com`), a subdomain (for example,
    /// `login.example.com` or `admin.login.example.com`), or a wildcard (for
    /// example, `*.example.com`).
    domain_name: []const u8,

    /// When `true`, the subdomain `www.*DomainName*
    /// ` is associated with the App Runner service in addition to the base
    /// domain.
    enable_www_subdomain: bool,

    /// The current state of the domain name association.
    status: CustomDomainAssociationStatus,

    pub const json_field_names = .{
        .certificate_validation_records = "CertificateValidationRecords",
        .domain_name = "DomainName",
        .enable_www_subdomain = "EnableWWWSubdomain",
        .status = "Status",
    };
};
