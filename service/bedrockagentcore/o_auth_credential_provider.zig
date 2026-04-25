const aws = @import("aws");

const OAuthGrantType = @import("o_auth_grant_type.zig").OAuthGrantType;

/// Configuration for an OAuth 2.0 credential provider used to authenticate tool
/// calls.
pub const OAuthCredentialProvider = struct {
    /// Additional custom parameters to include in the OAuth 2.0 token request.
    custom_parameters: ?[]const aws.map.StringMapEntry = null,

    /// The default return URL for the OAuth 2.0 authorization flow.
    default_return_url: ?[]const u8 = null,

    /// The OAuth 2.0 grant type to use for authentication.
    grant_type: OAuthGrantType = .client_credentials,

    /// The ARN of the OAuth 2.0 credential provider in AgentCore Identity.
    provider_arn: []const u8,

    /// The OAuth 2.0 scopes to request when obtaining an access token.
    scopes: []const []const u8,

    pub const json_field_names = .{
        .custom_parameters = "customParameters",
        .default_return_url = "defaultReturnUrl",
        .grant_type = "grantType",
        .provider_arn = "providerArn",
        .scopes = "scopes",
    };
};
