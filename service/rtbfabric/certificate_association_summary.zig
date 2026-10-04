const CertificateAssociationStatus = @import("certificate_association_status.zig").CertificateAssociationStatus;

/// Describes a summary of a certificate association.
pub const CertificateAssociationSummary = struct {
    /// The Amazon Resource Name (ARN) of the ACM certificate.
    acm_certificate_arn: []const u8,

    /// The timestamp of when the certificate was associated.
    associated_at: ?i64 = null,

    /// The status of the certificate association.
    status: CertificateAssociationStatus,

    /// The timestamp of when the certificate association was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .acm_certificate_arn = "acmCertificateArn",
        .associated_at = "associatedAt",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
