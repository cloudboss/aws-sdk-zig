/// Localized text strings for a specific language that customize the web
/// portal.
pub const LocalizedBrandingStrings = struct {
    /// The text displayed in the browser tab title.
    browser_tab_title: []const u8,

    /// The text displayed on the contact button. This field is optional and
    /// defaults to "Contact us".
    contact_button_text: ?[]const u8,

    /// A contact link URL. The URL must start with `https://` or `mailto:`. If not
    /// provided, the contact button will be hidden from the web portal screen.
    contact_link: ?[]const u8,

    /// The text displayed during session loading. This field is optional and
    /// defaults to "Loading your session".
    loading_text: ?[]const u8,

    /// The text displayed on the login button. This field is optional and defaults
    /// to "Sign In".
    login_button_text: ?[]const u8,

    /// The description text for the login section. This field is optional and
    /// defaults to "Sign in to your session".
    login_description: ?[]const u8,

    /// The title text for the login section. This field is optional and defaults to
    /// "Sign In".
    login_title: ?[]const u8,

    /// The welcome text displayed on the sign-in page.
    welcome_text: []const u8,

    pub const json_field_names = .{
        .browser_tab_title = "browserTabTitle",
        .contact_button_text = "contactButtonText",
        .contact_link = "contactLink",
        .loading_text = "loadingText",
        .login_button_text = "loginButtonText",
        .login_description = "loginDescription",
        .login_title = "loginTitle",
        .welcome_text = "welcomeText",
    };
};
