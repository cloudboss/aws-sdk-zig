/// CDN Authorization credentials
pub const Authorization = struct {
    /// The Amazon Resource Name (ARN) for the secret in Secrets Manager that your
    /// Content Distribution Network (CDN) uses for authorization to access your
    /// endpoint.
    cdn_identifier_secret: []const u8,

    /// The Amazon Resource Name (ARN) for the IAM role that allows MediaPackage to
    /// communicate with AWS Secrets Manager.
    secrets_role_arn: []const u8,

    pub const json_field_names = .{
        .cdn_identifier_secret = "CdnIdentifierSecret",
        .secrets_role_arn = "SecretsRoleArn",
    };
};
