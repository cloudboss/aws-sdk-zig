const PublicCertificateAuthority = @import("public_certificate_authority.zig").PublicCertificateAuthority;

/// Defines the certificate authority to use for an ACME endpoint.
pub const CertificateAuthority = union(enum) {
    /// Configuration for using a public certificate authority.
    public_certificate_authority: ?PublicCertificateAuthority,

    pub const json_field_names = .{
        .public_certificate_authority = "PublicCertificateAuthority",
    };
};
