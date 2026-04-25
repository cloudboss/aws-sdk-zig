const CertificateMetadata = @import("certificate_metadata.zig").CertificateMetadata;
const X509Attributes = @import("x509_attributes.zig").X509Attributes;

/// Contains information about a certificate returned by the SearchCertificates
/// action. This structure includes the certificate ARN, X.509 attributes, and
/// ACM metadata.
pub const CertificateSearchResult = struct {
    /// The Amazon Resource Name (ARN) of the certificate.
    certificate_arn: ?[]const u8 = null,

    /// ACM-specific metadata about the certificate.
    certificate_metadata: ?CertificateMetadata = null,

    /// X.509 certificate attributes such as subject, issuer, and validity period.
    x509_attributes: ?X509Attributes = null,

    pub const json_field_names = .{
        .certificate_arn = "CertificateArn",
        .certificate_metadata = "CertificateMetadata",
        .x509_attributes = "X509Attributes",
    };
};
