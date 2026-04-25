const ServiceConnectTlsCertificateAuthority = @import("service_connect_tls_certificate_authority.zig").ServiceConnectTlsCertificateAuthority;

/// The key that encrypts and decrypts your resources for Service Connect TLS.
pub const ServiceConnectTlsConfiguration = struct {
    /// The signer certificate authority.
    issuer_certificate_authority: ServiceConnectTlsCertificateAuthority,

    /// The Amazon Web Services Key Management Service key.
    kms_key: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role that's associated with the
    /// Service Connect TLS.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .issuer_certificate_authority = "issuerCertificateAuthority",
        .kms_key = "kmsKey",
        .role_arn = "roleArn",
    };
};
