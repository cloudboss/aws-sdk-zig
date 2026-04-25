const AcmCertificateMetadata = @import("acm_certificate_metadata.zig").AcmCertificateMetadata;

/// Contains metadata about a certificate. Currently supports ACM certificate
/// metadata.
pub const CertificateMetadata = union(enum) {
    /// Metadata for an ACM certificate.
    acm_certificate_metadata: ?AcmCertificateMetadata,

    pub const json_field_names = .{
        .acm_certificate_metadata = "AcmCertificateMetadata",
    };
};
