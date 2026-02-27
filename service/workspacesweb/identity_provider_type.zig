pub const IdentityProviderType = enum {
    saml,
    facebook,
    google,
    login_with_amazon,
    sign_in_with_apple,
    oidc,

    pub const json_field_names = .{
        .saml = "SAML",
        .facebook = "Facebook",
        .google = "Google",
        .login_with_amazon = "LoginWithAmazon",
        .sign_in_with_apple = "SignInWithApple",
        .oidc = "OIDC",
    };
};
