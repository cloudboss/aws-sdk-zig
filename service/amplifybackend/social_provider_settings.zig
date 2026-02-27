const BackendAuthSocialProviderConfig = @import("backend_auth_social_provider_config.zig").BackendAuthSocialProviderConfig;
const BackendAuthAppleProviderConfig = @import("backend_auth_apple_provider_config.zig").BackendAuthAppleProviderConfig;

/// The settings for using the social identity providers for access to your
/// Amplify app.
pub const SocialProviderSettings = struct {
    facebook: ?BackendAuthSocialProviderConfig,

    google: ?BackendAuthSocialProviderConfig,

    login_with_amazon: ?BackendAuthSocialProviderConfig,

    sign_in_with_apple: ?BackendAuthAppleProviderConfig,

    pub const json_field_names = .{
        .facebook = "Facebook",
        .google = "Google",
        .login_with_amazon = "LoginWithAmazon",
        .sign_in_with_apple = "SignInWithApple",
    };
};
