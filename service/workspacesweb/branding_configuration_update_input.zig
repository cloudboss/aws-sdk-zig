const aws = @import("aws");

const ColorTheme = @import("color_theme.zig").ColorTheme;
const IconImageInput = @import("icon_image_input.zig").IconImageInput;
const LocalizedBrandingStrings = @import("localized_branding_strings.zig").LocalizedBrandingStrings;
const WallpaperImageInput = @import("wallpaper_image_input.zig").WallpaperImageInput;

/// The input configuration for updating branding settings. All fields are
/// optional when updating existing branding.
pub const BrandingConfigurationUpdateInput = struct {
    /// The color theme for components on the web portal. Choose `Light` if you
    /// upload a dark wallpaper, or `Dark` for a light wallpaper.
    color_theme: ?ColorTheme = null,

    /// The favicon image for the portal. Provide either a binary image file or an
    /// S3 URI pointing to the image file. Maximum 100 KB in JPEG, PNG, or ICO
    /// format.
    favicon: ?IconImageInput = null,

    /// A map of localized text strings for different supported languages. Each
    /// locale must provide the required fields `browserTabTitle` and `welcomeText`.
    localized_strings: ?[]const aws.map.MapEntry(LocalizedBrandingStrings) = null,

    /// The logo image for the portal. Provide either a binary image file or an S3
    /// URI pointing to the image file. Maximum 100 KB in JPEG, PNG, or ICO format.
    logo: ?IconImageInput = null,

    /// The terms of service text in Markdown format. To remove existing terms of
    /// service, provide an empty string.
    terms_of_service: ?[]const u8 = null,

    /// The wallpaper image for the portal. Provide either a binary image file or an
    /// S3 URI pointing to the image file. Maximum 5 MB in JPEG or PNG format.
    wallpaper: ?WallpaperImageInput = null,

    pub const json_field_names = .{
        .color_theme = "colorTheme",
        .favicon = "favicon",
        .localized_strings = "localizedStrings",
        .logo = "logo",
        .terms_of_service = "termsOfService",
        .wallpaper = "wallpaper",
    };
};
