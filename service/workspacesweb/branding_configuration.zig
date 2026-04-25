const aws = @import("aws");

const ColorTheme = @import("color_theme.zig").ColorTheme;
const ImageMetadata = @import("image_metadata.zig").ImageMetadata;
const LocalizedBrandingStrings = @import("localized_branding_strings.zig").LocalizedBrandingStrings;

/// The branding configuration output including custom images metadata,
/// localized strings, color theme, and terms of service.
pub const BrandingConfiguration = struct {
    /// The color theme for components on the web portal.
    color_theme: ColorTheme,

    /// Metadata for the favicon image file, including the MIME type, file
    /// extension, and upload timestamp.
    favicon: ImageMetadata,

    /// A map of localized text strings for different languages, allowing the portal
    /// to display content in the user's preferred language.
    localized_strings: []const aws.map.MapEntry(LocalizedBrandingStrings),

    /// Metadata for the logo image file, including the MIME type, file extension,
    /// and upload timestamp.
    logo: ImageMetadata,

    /// The terms of service text in Markdown format that users must accept before
    /// accessing the portal.
    terms_of_service: ?[]const u8 = null,

    /// Metadata for the wallpaper image file, including the MIME type, file
    /// extension, and upload timestamp.
    wallpaper: ?ImageMetadata = null,

    pub const json_field_names = .{
        .color_theme = "colorTheme",
        .favicon = "favicon",
        .localized_strings = "localizedStrings",
        .logo = "logo",
        .terms_of_service = "termsOfService",
        .wallpaper = "wallpaper",
    };
};
