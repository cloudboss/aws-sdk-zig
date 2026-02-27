const HttpRedirect = @import("http_redirect.zig").HttpRedirect;
const ResourceRecord = @import("resource_record.zig").ResourceRecord;
const ValidationMethod = @import("validation_method.zig").ValidationMethod;
const DomainStatus = @import("domain_status.zig").DomainStatus;

/// Contains information about the validation of each domain name in the
/// certificate.
pub const DomainValidation = struct {
    /// A fully qualified domain name (FQDN) in the certificate. For example,
    /// `www.example.com` or `example.com`.
    domain_name: []const u8,

    /// Contains information for HTTP-based domain validation of certificates
    /// requested through Amazon CloudFront and issued by ACM. This field exists
    /// only when the certificate type is `AMAZON_ISSUED` and the validation method
    /// is `HTTP`.
    http_redirect: ?HttpRedirect,

    /// Contains the CNAME record that you add to your DNS database for domain
    /// validation. For more information, see [Use DNS to Validate Domain
    /// Ownership](https://docs.aws.amazon.com/acm/latest/userguide/gs-acm-validate-dns.html).
    ///
    /// The CNAME information that you need does not include the name of your
    /// domain. If you include your domain name in the DNS database CNAME record,
    /// validation fails. For example, if the name is
    /// `_a79865eb4cd1a6ab990a45779b4e0b96.yourdomain.com`, only
    /// `_a79865eb4cd1a6ab990a45779b4e0b96` must be used.
    resource_record: ?ResourceRecord,

    /// The domain name that ACM used to send domain validation emails.
    validation_domain: ?[]const u8,

    /// A list of email addresses that ACM used to send domain validation emails.
    validation_emails: ?[]const []const u8,

    /// Specifies the domain validation method.
    validation_method: ?ValidationMethod,

    /// The validation status of the domain name. This can be one of the following
    /// values:
    ///
    /// * `PENDING_VALIDATION`
    /// * SUCCESS
    /// * FAILED
    validation_status: ?DomainStatus,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .http_redirect = "HttpRedirect",
        .resource_record = "ResourceRecord",
        .validation_domain = "ValidationDomain",
        .validation_emails = "ValidationEmails",
        .validation_method = "ValidationMethod",
        .validation_status = "ValidationStatus",
    };
};
