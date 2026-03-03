const AwsCertificateManagerCertificateResourceRecord = @import("aws_certificate_manager_certificate_resource_record.zig").AwsCertificateManagerCertificateResourceRecord;

/// Contains information about one of the following:
///
/// * The initial validation of each domain name that occurs as a result of the
/// `RequestCertificate` request
///
/// * The validation of each domain name in the certificate, as it pertains to
///   Certificate Manager managed renewal
pub const AwsCertificateManagerCertificateDomainValidationOption = struct {
    /// A fully qualified domain name (FQDN) in the certificate.
    domain_name: ?[]const u8 = null,

    /// The CNAME record that is added to the DNS database for domain validation.
    resource_record: ?AwsCertificateManagerCertificateResourceRecord = null,

    /// The domain name that Certificate Manager uses to send domain validation
    /// emails.
    validation_domain: ?[]const u8 = null,

    /// A list of email addresses that Certificate Manager uses to send domain
    /// validation
    /// emails.
    validation_emails: ?[]const []const u8 = null,

    /// The method used to validate the domain name.
    validation_method: ?[]const u8 = null,

    /// The validation status of the domain name.
    validation_status: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .resource_record = "ResourceRecord",
        .validation_domain = "ValidationDomain",
        .validation_emails = "ValidationEmails",
        .validation_method = "ValidationMethod",
        .validation_status = "ValidationStatus",
    };
};
