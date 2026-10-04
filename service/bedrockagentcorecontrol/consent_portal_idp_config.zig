/// The identity provider configuration used to authenticate end users to the
/// consent portal.
pub const ConsentPortalIdpConfig = struct {
    /// The audience value that the consent portal includes when requesting tokens
    /// from the identity provider.
    audience: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the OAuth2 credential provider used to
    /// authenticate end users to the consent portal.
    credential_provider_arn: []const u8,

    /// The OAuth2 scopes that the consent portal requests when authenticating end
    /// users.
    scopes: []const []const u8,

    pub const json_field_names = .{
        .audience = "audience",
        .credential_provider_arn = "credentialProviderArn",
        .scopes = "scopes",
    };
};
