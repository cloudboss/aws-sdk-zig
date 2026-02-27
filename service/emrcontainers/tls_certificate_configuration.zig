const CertificateProviderType = @import("certificate_provider_type.zig").CertificateProviderType;

/// Configurations related to the TLS certificate for the security
/// configuration.
pub const TLSCertificateConfiguration = struct {
    /// The TLS certificate type. Acceptable values: `PEM` or
    /// `Custom`.
    certificate_provider_type: ?CertificateProviderType,

    /// Secrets Manager ARN that contains the private TLS certificate contents, used
    /// for
    /// communication between the user job and the system job.
    private_certificate_secret_arn: ?[]const u8,

    /// Secrets Manager ARN that contains the public TLS certificate contents, used
    /// for
    /// communication between the user job and the system job.
    public_certificate_secret_arn: ?[]const u8,

    pub const json_field_names = .{
        .certificate_provider_type = "certificateProviderType",
        .private_certificate_secret_arn = "privateCertificateSecretArn",
        .public_certificate_secret_arn = "publicCertificateSecretArn",
    };
};
