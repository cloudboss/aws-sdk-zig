const OAuthGrantType = @import("o_auth_grant_type.zig").OAuthGrantType;
const OAuthScopesElement = @import("o_auth_scopes_element.zig").OAuthScopesElement;
const SocialProviderSettings = @import("social_provider_settings.zig").SocialProviderSettings;

/// Creates the OAuth configuration for your Amplify project.
pub const CreateBackendAuthOAuthConfig = struct {
    /// The domain prefix for your Amplify app.
    domain_prefix: ?[]const u8 = null,

    /// The OAuth grant type that you use to allow app users to authenticate from
    /// your Amplify app.
    o_auth_grant_type: OAuthGrantType,

    /// List of OAuth-related flows used to allow your app users to authenticate
    /// from your Amplify app.
    o_auth_scopes: []const OAuthScopesElement,

    /// The redirected URI for signing in to your Amplify app.
    redirect_sign_in_ur_is: []const []const u8,

    /// Redirect URLs that OAuth uses when a user signs out of an Amplify app.
    redirect_sign_out_ur_is: []const []const u8,

    /// The settings for using social providers to access your Amplify app.
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
