/// The credentials for Microsoft Purview DLP integration. The credentials are
/// stored in Amazon Web Services Secrets Manager and referenced by ARN.
pub const MicrosoftPurviewCredentials = struct {
    /// The ARN of the Amazon Web Services Secrets Manager secret that contains the
    /// Microsoft Purview OAuth credentials. The secret includes the Azure tenant
    /// ID, client ID, and client secret or certificate.
    secret_arn: []const u8,

    pub const json_field_names = .{
        .secret_arn = "SecretArn",
    };
};
