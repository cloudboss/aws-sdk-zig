/// Contains the configuration information to customize the logo, font, and
/// color of an Amazon Q Business web experience with individual files for each
/// property or a CSS file for them all.
pub const CustomizationConfiguration = struct {
    /// Provides the URL where the custom CSS file is hosted for an Amazon Q web
    /// experience.
    custom_css_url: ?[]const u8,

    /// Provides the URL where the custom favicon file is hosted for an Amazon Q web
    /// experience.
    favicon_url: ?[]const u8,

    /// Provides the URL where the custom font file is hosted for an Amazon Q web
    /// experience.
    font_url: ?[]const u8,

    /// Provides the URL where the custom logo file is hosted for an Amazon Q web
    /// experience.
    logo_url: ?[]const u8,

    pub const json_field_names = .{
        .custom_css_url = "customCSSUrl",
        .favicon_url = "faviconUrl",
        .font_url = "fontUrl",
        .logo_url = "logoUrl",
    };
};
