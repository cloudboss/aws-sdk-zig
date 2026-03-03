const aws = @import("aws");

/// The client branding attributes to import for iOS device types. These
/// attributes are
/// displayed on the iOS client login screen.
///
/// Client branding attributes are public facing. Ensure you do not include
/// sensitive
/// information.
pub const IosImportClientBrandingAttributes = struct {
    /// The forgotten password link. This is the web address that users can go to if
    /// they forget
    /// the password for their WorkSpace.
    forgot_password_link: ?[]const u8 = null,

    /// The login message. Specified as a key value pair, in which the key is a
    /// locale and the
    /// value is the localized message for that locale. The only key supported is
    /// `en_US`. The HTML tags supported include the following: `a, b, blockquote,
    /// br, cite, code, dd, dl, dt, div, em,
    /// i, li, ol, p, pre, q, small, span, strike, strong, sub, sup, u, ul`.
    login_message: ?[]const aws.map.StringMapEntry = null,

    /// The logo. This is the
    /// standard-resolution display that has a 1:1 pixel density (or @1x), where one
    /// pixel is equal
    /// to one point. The only image format accepted is a binary data object that is
    /// converted
    /// from a `.png` file.
    logo: ?[]const u8 = null,

    /// The @2x version of the logo. This is the higher resolution display that
    /// offers a scale
    /// factor of 2.0 (or @2x). The only image format accepted is a binary data
    /// object that is
    /// converted from a `.png` file.
    ///
    /// For more information about iOS image size and resolution, see [Image Size
    /// and Resolution
    /// ](https://developer.apple.com/design/human-interface-guidelines/ios/icons-and-images/image-size-and-resolution/) in the *Apple Human Interface
    /// Guidelines*.
    logo_2_x: ?[]const u8 = null,

    /// The @3x version of the logo. This is the higher resolution display that
    /// offers a scale
    /// factor of 3.0 (or @3x). The only image format accepted is a binary data
    /// object that is
    /// converted from a `.png` file.
    ///
    /// For more information about iOS image size and resolution, see [Image Size
    /// and Resolution
    /// ](https://developer.apple.com/design/human-interface-guidelines/ios/icons-and-images/image-size-and-resolution/) in the *Apple Human Interface
    /// Guidelines*.
    logo_3_x: ?[]const u8 = null,

    /// The support email. The company's customer support email address.
    ///
    /// * In each platform type, the `SupportEmail` and
    /// `SupportLink` parameters are mutually exclusive. You can specify one
    /// parameter for each platform type, but not both.
    ///
    /// * The default email is `workspaces-feedback@amazon.com`.
    support_email: ?[]const u8 = null,

    /// The support link. The link for the company's customer support page for their
    /// WorkSpace.
    ///
    /// * In each platform type, the `SupportEmail` and
    /// `SupportLink` parameters are mutually exclusive. You can specify one
    /// parameter for each platform type, but not both.
    ///
    /// * The default support link is `workspaces-feedback@amazon.com`.
    support_link: ?[]const u8 = null,

    pub const json_field_names = .{
        .forgot_password_link = "ForgotPasswordLink",
        .login_message = "LoginMessage",
        .logo = "Logo",
        .logo_2_x = "Logo2x",
        .logo_3_x = "Logo3x",
        .support_email = "SupportEmail",
        .support_link = "SupportLink",
    };
};
