const aws = @import("aws");

const OAuthGrantType = @import("o_auth_grant_type.zig").OAuthGrantType;

/// An OAuth credential provider for gateway authentication. This structure
/// contains the configuration for authenticating with the target endpoint using
/// OAuth.
pub const OAuthCredentialProvider = struct {
    /// The custom parameters for the OAuth credential provider. These parameters
    /// provide additional configuration for the OAuth authentication process.
    custom_parameters: ?[]const aws.map.StringMapEntry = null,

    /// The URL where the end user's browser is redirected after obtaining the
    /// authorization code. Generally points to the customer's application.
    default_return_url: ?[]const u8 = null,

    /// Specifies the kind of credentials to use for authorization:
    ///
    /// * `CLIENT_CREDENTIALS` - Authorization with a client ID and secret.
    /// * `AUTHORIZATION_CODE` - Authorization with a token that is specific to an
    ///   individual end user.
    grant_type: OAuthGrantType = "CLIENT_CREDENTIALS",

    /// The Amazon Resource Name (ARN) of the OAuth credential provider. This ARN
    /// identifies the provider in Amazon Web Services.
    provider_arn: []const u8,

    /// The OAuth scopes for the credential provider. These scopes define the level
    /// of access requested from the OAuth provider.
    scopes: []const []const u8,

    pub const json_field_names = .{
        .custom_parameters = "customParameters",
        .default_return_url = "defaultReturnUrl",
        .grant_type = "grantType",
        .provider_arn = "providerArn",
        .scopes = "scopes",
    };
};
