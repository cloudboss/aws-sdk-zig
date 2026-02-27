const aws = @import("aws");

const ColorTheme = @import("color_theme.zig").ColorTheme;
const IconImageInput = @import("icon_image_input.zig").IconImageInput;
const LocalizedBrandingStrings = @import("localized_branding_strings.zig").LocalizedBrandingStrings;
const WallpaperImageInput = @import("wallpaper_image_input.zig").WallpaperImageInput;

/// The input configuration for creating branding settings.
pub const BrandingConfigurationCreateInput = struct {
    /// The color theme for components on the web portal. Choose `Light` if you
    /// upload a dark wallpaper, or `Dark` for a light wallpaper.
    color_theme: ColorTheme,

    /// The favicon image for the portal. Provide either a binary image file or an
    /// S3 URI pointing to the image file. Maximum 100 KB in JPEG, PNG, or ICO
    /// format.
    favicon: IconImageInput,

    /// A map of localized text strings for different supported languages. Each
    /// locale must provide the required fields `browserTabTitle` and `welcomeText`.
    localized_strings: []const aws.map.MapEntry(LocalizedBrandingStrings),

    /// The logo image for the portal. Provide either a binary image file or an S3
    /// URI pointing to the image file. Maximum 100 KB in JPEG, PNG, or ICO format.
    logo: IconImageInput,

    /// The terms of service text in Markdown format. Users will be presented with
    /// the terms of service after successfully signing in.
    terms_of_service: ?[]const u8,

    /// The wallpaper image for the portal. Provide either a binary image file or an
    /// S3 URI pointing to the image file. Maximum 5 MB in JPEG or PNG format.
    wallpaper: WallpaperImageInput,

    pub const json_field_names = .{
        .color_theme = "colorTheme",
        .favicon = "favicon",
        .localized_strings = "localizedStrings",
        .logo = "logo",
        .terms_of_service = "termsOfService",
        .wallpaper = "wallpaper",
    };
};
