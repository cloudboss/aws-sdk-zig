/// Information about the OIDC-compliant identity provider (IdP) used to
/// authenticate end users of an Amazon Q Business web experience.
pub const OpenIDConnectProviderConfiguration = struct {
    /// The Amazon Resource Name (ARN) of a Secrets Manager secret containing the
    /// OIDC client secret.
    secrets_arn: []const u8,

    /// An IAM role with permissions to access KMS to decrypt the Secrets Manager
    /// secret containing your OIDC client secret.
    secrets_role: []const u8,

    pub const json_field_names = .{
        .secrets_arn = "secretsArn",
        .secrets_role = "secretsRole",
    };
};
