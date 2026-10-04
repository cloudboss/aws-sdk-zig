const CertificateAuthorityActivatedBy = @import("certificate_authority_activated_by.zig").CertificateAuthorityActivatedBy;

/// Identifies the certificate authority that is currently signing certificates
/// for the
/// cluster.
pub const ActiveCertificateAuthority = struct {
    /// The entity that activated the current signing certificate authority, either
    /// `CUSTOMER` or `EKS`.
    activated_by: ?CertificateAuthorityActivatedBy = null,

    /// The unique identifier of the certificate authority that is currently signing
    /// certificates for the cluster.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .activated_by = "activatedBy",
        .id = "id",
    };
};
