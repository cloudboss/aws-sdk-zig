const CertificateAuthorityActivatedBy = @import("certificate_authority_activated_by.zig").CertificateAuthorityActivatedBy;
const CertificateAuthorityCreatedBy = @import("certificate_authority_created_by.zig").CertificateAuthorityCreatedBy;
const CertificateAuthorityDistributionStatus = @import("certificate_authority_distribution_status.zig").CertificateAuthorityDistributionStatus;
const CertificateAuthorityScheduledEvents = @import("certificate_authority_scheduled_events.zig").CertificateAuthorityScheduledEvents;
const CertificateAuthoritySigningStatus = @import("certificate_authority_signing_status.zig").CertificateAuthoritySigningStatus;
const CertificateAuthorityValidity = @import("certificate_authority_validity.zig").CertificateAuthorityValidity;

/// An object representing a certificate authority (CA) for an Amazon EKS
/// cluster.
pub const CertificateAuthority = struct {
    /// The Unix epoch timestamp in seconds for when the certificate authority was
    /// last
    /// activated as the cluster's signer. This value is absent if the certificate
    /// authority has
    /// never been activated.
    activated_at: ?i64 = null,

    /// The entity that most recently activated the certificate authority. A value
    /// of
    /// `EKS` indicates that Amazon EKS activated it automatically; `CUSTOMER`
    /// indicates that you activated it.
    activated_by: ?CertificateAuthorityActivatedBy = null,

    /// The Unix epoch timestamp in seconds for when the certificate authority was
    /// created.
    created_at: ?i64 = null,

    /// The entity that created the certificate authority. Certificate authorities
    /// that you
    /// create are `CUSTOMER`; those that Amazon EKS provisions on your behalf, such
    /// as a
    /// cluster's initial certificate authority, are `EKS`.
    created_by: ?CertificateAuthorityCreatedBy = null,

    /// The Base64-encoded public certificate of the certificate authority.
    data: ?[]const u8 = null,

    /// The distribution status of the certificate authority, which tracks whether
    /// Amazon EKS has
    /// distributed its trust to the Amazon Web Services managed components in your
    /// cluster (the control plane,
    /// Amazon EKS Auto Mode instances, and Amazon Web Services Fargate nodes).
    /// Valid values are
    /// `IN_PROGRESS`, `COMPLETE`, `FAILED`, and
    /// `DELETING`. A successor CA can only be activated after its distribution
    /// status is `COMPLETE`.
    distribution_status: ?CertificateAuthorityDistributionStatus = null,

    /// The unique identifier of the certificate authority.
    id: ?[]const u8 = null,

    /// Indicates whether CA rollback is still available for this certificate
    /// authority. After
    /// you activate a successor CA, rollback lets you revert to the outgoing CA for
    /// a limited
    /// period while you finish updating any worker nodes or clients that were
    /// missed.
    rollback_available: ?bool = null,

    /// The scheduled auto-activation events for the certificate authority, computed
    /// from its
    /// validity period.
    scheduled_events: ?CertificateAuthorityScheduledEvents = null,

    /// The signing status of the certificate authority. `IN_USE` means the
    /// certificate authority is currently signing certificates for the cluster,
    /// `ACTIVATING` means it's being promoted to the signer, and
    /// `NOT_USED` means it's trusted by the cluster (for example, a successor CA
    /// during a rotation, or a retired outgoing CA) but isn't the signer.
    signing_status: ?CertificateAuthoritySigningStatus = null,

    /// The validity period of the certificate authority's certificate.
    validity: ?CertificateAuthorityValidity = null,

    pub const json_field_names = .{
        .activated_at = "activatedAt",
        .activated_by = "activatedBy",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .data = "data",
        .distribution_status = "distributionStatus",
        .id = "id",
        .rollback_available = "rollbackAvailable",
        .scheduled_events = "scheduledEvents",
        .signing_status = "signingStatus",
        .validity = "validity",
    };
};
