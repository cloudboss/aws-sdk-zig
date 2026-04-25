const AcmCertificateMetadataFilter = @import("acm_certificate_metadata_filter.zig").AcmCertificateMetadataFilter;
const X509AttributeFilter = @import("x509_attribute_filter.zig").X509AttributeFilter;

/// Defines a filter for searching certificates by ARN, X.509 attributes, or ACM
/// metadata.
pub const CertificateFilter = union(enum) {
    /// Filter by ACM certificate metadata.
    acm_certificate_metadata_filter: ?AcmCertificateMetadataFilter,
    /// Filter by certificate ARN.
    certificate_arn: ?[]const u8,
    /// Filter by X.509 certificate attributes.
    x509_attribute_filter: ?X509AttributeFilter,

    pub const json_field_names = .{
        .acm_certificate_metadata_filter = "AcmCertificateMetadataFilter",
        .certificate_arn = "CertificateArn",
        .x509_attribute_filter = "X509AttributeFilter",
    };
};
