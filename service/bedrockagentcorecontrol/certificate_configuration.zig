const S3CertificateConfiguration = @import("s3_certificate_configuration.zig").S3CertificateConfiguration;
const SecretsManagerCertificateConfiguration = @import("secrets_manager_certificate_configuration.zig").SecretsManagerCertificateConfiguration;

/// A reference to a private certificate authority (CA) certificate that the
/// gateway uses to verify TLS connections to the target endpoint. Use this when
/// the target presents a certificate issued by a private CA that is not trusted
/// by default. Specify exactly one certificate source. The configuration is a
/// reference only and never contains the certificate content.
pub const CertificateConfiguration = union(enum) {
    /// The Amazon S3 location of the PEM-encoded private CA certificate.
    s_3: ?S3CertificateConfiguration,
    /// The Amazon Web Services Secrets Manager location of the PEM-encoded private
    /// CA certificate.
    secrets_manager: ?SecretsManagerCertificateConfiguration,

    pub const json_field_names = .{
        .s_3 = "s3",
        .secrets_manager = "secretsManager",
    };
};
