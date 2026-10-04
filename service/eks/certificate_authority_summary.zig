const CertificateAuthorityActivatedBy = @import("certificate_authority_activated_by.zig").CertificateAuthorityActivatedBy;
const CertificateAuthorityCreatedBy = @import("certificate_authority_created_by.zig").CertificateAuthorityCreatedBy;
const CertificateAuthorityDistributionStatus = @import("certificate_authority_distribution_status.zig").CertificateAuthorityDistributionStatus;
const CertificateAuthoritySigningStatus = @import("certificate_authority_signing_status.zig").CertificateAuthoritySigningStatus;

/// Summary information about a certificate authority (CA) for an Amazon EKS
/// cluster, returned by
/// [
/// `ListCertificateAuthorities`
/// ](https://docs.aws.amazon.com/eks/latest/APIReference/API_ListCertificateAuthorities.html) and the certificate-authority write
/// operations.
pub const CertificateAuthoritySummary = struct {
    /// The Unix epoch timestamp in seconds for when the certificate authority was
    /// last
    /// activated. This value is absent if the certificate authority has never been
    /// activated.
    activated_at: ?i64 = null,

    /// The entity that most recently activated the certificate authority, either
    /// `CUSTOMER` or `EKS`.
    activated_by: ?CertificateAuthorityActivatedBy = null,

    /// The Unix epoch timestamp in seconds for when the certificate authority was
    /// created.
    created_at: ?i64 = null,

    /// The entity that created the certificate authority, either `CUSTOMER` or
    /// `EKS`.
    created_by: ?CertificateAuthorityCreatedBy = null,

    /// The distribution status of the certificate authority: `IN_PROGRESS`,
    /// `COMPLETE`, `FAILED`, or `DELETING`.
    distribution_status: ?CertificateAuthorityDistributionStatus = null,

    /// The unique identifier of the certificate authority.
    id: ?[]const u8 = null,

    /// The signing status of the certificate authority: `IN_USE`,
    /// `ACTIVATING`, or `NOT_USED`.
    signing_status: ?CertificateAuthoritySigningStatus = null,

    pub const json_field_names = .{
        .activated_at = "activatedAt",
        .activated_by = "activatedBy",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .distribution_status = "distributionStatus",
        .id = "id",
        .signing_status = "signingStatus",
    };
};
