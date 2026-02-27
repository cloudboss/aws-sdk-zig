const CertificateAssociation = @import("certificate_association.zig").CertificateAssociation;

/// Contains information about the custom domain name association.
pub const Association = struct {
    /// A list of all associated clusters and domain names tied to a specific
    /// certificate.
    certificate_associations: ?[]const CertificateAssociation,

    /// The Amazon Resource Name (ARN) for the certificate associated with the
    /// custom domain.
    custom_domain_certificate_arn: ?[]const u8,

    /// The expiration date for the certificate.
    custom_domain_certificate_expiry_date: ?i64,
};
