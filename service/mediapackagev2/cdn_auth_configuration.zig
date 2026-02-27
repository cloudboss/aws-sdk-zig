/// The settings to enable CDN authorization headers in MediaPackage.
pub const CdnAuthConfiguration = struct {
    /// The ARN for the secret in Secrets Manager that your CDN uses for
    /// authorization to access the endpoint.
    cdn_identifier_secret_arns: []const []const u8,

    /// The ARN for the IAM role that gives MediaPackage read access to Secrets
    /// Manager and KMS for CDN authorization.
    secrets_role_arn: []const u8,

    pub const json_field_names = .{
        .cdn_identifier_secret_arns = "CdnIdentifierSecretArns",
        .secrets_role_arn = "SecretsRoleArn",
    };
};
