const OAuthGrantType = @import("o_auth_grant_type.zig").OAuthGrantType;
const OAuthScopesElement = @import("o_auth_scopes_element.zig").OAuthScopesElement;
const SocialProviderSettings = @import("social_provider_settings.zig").SocialProviderSettings;

/// The OAuth configurations for authenticating users into your Amplify app.
pub const UpdateBackendAuthOAuthConfig = struct {
    /// The Amazon Cognito domain prefix used to create a hosted UI for
    /// authentication.
    domain_prefix: ?[]const u8 = null,

    /// The OAuth grant type to allow app users to authenticate from your Amplify
    /// app.
    o_auth_grant_type: ?OAuthGrantType = null,

    /// The list of OAuth-related flows that can allow users to authenticate from
    /// your Amplify app.
    o_auth_scopes: ?[]const OAuthScopesElement = null,

    /// Redirect URLs that OAuth uses when a user signs in to an Amplify app.
    redirect_sign_in_ur_is: ?[]const []const u8 = null,

    /// Redirect URLs that OAuth uses when a user signs out of an Amplify app.
    redirect_sign_out_ur_is: ?[]const []const u8 = null,

    /// Describes third-party social federation configurations for allowing your
    /// users to sign in with OAuth.
    social_provider_settings: ?SocialProviderSettings = null,

    pub const json_field_names = .{
        .domain_prefix = "DomainPrefix",
        .o_auth_grant_type = "OAuthGrantType",
        .o_auth_scopes = "OAuthScopes",
        .redirect_sign_in_ur_is = "RedirectSignInURIs",
        .redirect_sign_out_ur_is = "RedirectSignOutURIs",
        .social_provider_settings = "SocialProviderSettings",
    };
};
