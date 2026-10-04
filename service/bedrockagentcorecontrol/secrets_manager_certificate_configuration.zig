/// A reference to a PEM-encoded private CA certificate stored in an Amazon Web
/// Services Secrets Manager secret.
pub const SecretsManagerCertificateConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Web Services Secrets Manager
    /// secret that contains the PEM-encoded certificate.
    secret_arn: []const u8,

    pub const json_field_names = .{
        .secret_arn = "secretArn",
    };
};
