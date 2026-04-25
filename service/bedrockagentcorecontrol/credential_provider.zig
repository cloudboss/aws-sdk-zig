const GatewayApiKeyCredentialProvider = @import("gateway_api_key_credential_provider.zig").GatewayApiKeyCredentialProvider;
const IamCredentialProvider = @import("iam_credential_provider.zig").IamCredentialProvider;
const OAuthCredentialProvider = @import("o_auth_credential_provider.zig").OAuthCredentialProvider;

/// A credential provider for gateway authentication. This structure contains
/// the configuration for authenticating with the target endpoint.
pub const CredentialProvider = union(enum) {
    /// The API key credential provider. This provider uses an API key to
    /// authenticate with the target endpoint.
    api_key_credential_provider: ?GatewayApiKeyCredentialProvider,
    /// The IAM credential provider. This provider uses IAM authentication with
    /// SigV4 signing to access the target endpoint.
    iam_credential_provider: ?IamCredentialProvider,
    /// The OAuth credential provider. This provider uses OAuth authentication to
    /// access the target endpoint.
    oauth_credential_provider: ?OAuthCredentialProvider,

    pub const json_field_names = .{
        .api_key_credential_provider = "apiKeyCredentialProvider",
        .iam_credential_provider = "iamCredentialProvider",
        .oauth_credential_provider = "oauthCredentialProvider",
    };
};
