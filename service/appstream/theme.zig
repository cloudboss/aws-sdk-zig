const ThemeState = @import("theme_state.zig").ThemeState;
const ThemeFooterLink = @import("theme_footer_link.zig").ThemeFooterLink;
const ThemeStyling = @import("theme_styling.zig").ThemeStyling;

/// The custom branding theme, which might include a custom logo, website links,
/// and other branding to display to users.
pub const Theme = struct {
    /// The time the theme was created.
    created_time: ?i64 = null,

    /// The stack that has the custom branding theme.
    stack_name: ?[]const u8 = null,

    /// The state of the theme.
    state: ?ThemeState = null,

    /// The URL of the icon that displays at the top of a user's browser tab during
    /// streaming sessions.
    theme_favicon_url: ?[]const u8 = null,

    /// The website links that display in the catalog page footer.
    theme_footer_links: ?[]const ThemeFooterLink = null,

    /// The URL of the logo that displays in the catalog page header.
    theme_organization_logo_url: ?[]const u8 = null,

    /// The color that is used for the website links, text, buttons, and catalog
    /// page background.
    theme_styling: ?ThemeStyling = null,

    /// The browser tab page title.
    theme_title_text: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_time = "CreatedTime",
        .stack_name = "StackName",
        .state = "State",
        .theme_favicon_url = "ThemeFaviconURL",
        .theme_footer_links = "ThemeFooterLinks",
        .theme_organization_logo_url = "ThemeOrganizationLogoURL",
        .theme_styling = "ThemeStyling",
        .theme_title_text = "ThemeTitleText",
    };
};
