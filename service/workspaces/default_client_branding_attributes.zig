const aws = @import("aws");

/// Returns default client branding attributes that were imported. These
/// attributes display
/// on the client login screen.
///
/// Client branding attributes are public facing. Ensure that you don't include
/// sensitive
/// information.
pub const DefaultClientBrandingAttributes = struct {
    /// The forgotten password link. This is the web address that users can go to if
    /// they forget
    /// the password for their WorkSpace.
    forgot_password_link: ?[]const u8,

    /// The login message. Specified as a key value pair, in which the key is a
    /// locale and the
    /// value is the localized message for that locale. The only key supported is
    /// `en_US`. The HTML tags supported include the following: `a, b, blockquote,
    /// br, cite, code, dd, dl, dt, div, em,
    /// i, li, ol, p, pre, q, small, span, strike, strong, sub, sup, u, ul`.
    login_message: ?[]const aws.map.StringMapEntry,

    /// The logo. The only image format accepted is a binary data object that is
    /// converted from a `.png` file.
    logo_url: ?[]const u8,

    /// The support email. The company's customer support email address.
    ///
    /// * In each platform type, the `SupportEmail` and
    /// `SupportLink` parameters are mutually exclusive. You can specify one
    /// parameter for each platform type, but not both.
    ///
    /// * The default email is `workspaces-feedback@amazon.com`.
    support_email: ?[]const u8,

    /// The support link. The link for the company's customer support page for their
    /// WorkSpace.
    ///
    /// * In each platform type, the `SupportEmail` and
    /// `SupportLink` parameters are mutually exclusive.You can specify one
    /// parameter for each platform type, but not both.
    ///
    /// * The default support link is `workspaces-feedback@amazon.com`.
    support_link: ?[]const u8,

    pub const json_field_names = .{
        .forgot_password_link = "ForgotPasswordLink",
        .login_message = "LoginMessage",
        .logo_url = "LogoUrl",
        .support_email = "SupportEmail",
        .support_link = "SupportLink",
    };
};
