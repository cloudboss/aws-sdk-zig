/// Contains localized content for a partner profile in a specific language or
/// locale.
pub const LocalizedContent = struct {
    /// The localized description of the partner's business and services.
    description: []const u8,

    /// The localized display name for the partner.
    display_name: []const u8,

    /// The locale or language code for the localized content.
    locale: []const u8,

    /// The URL to the partner's logo image for this locale.
    logo_url: []const u8,

    /// The localized website URL for the partner.
    website_url: []const u8,

    pub const json_field_names = .{
        .description = "Description",
        .display_name = "DisplayName",
        .locale = "Locale",
        .logo_url = "LogoUrl",
        .website_url = "WebsiteUrl",
    };
};
