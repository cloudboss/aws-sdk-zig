/// The website links that display in the catalog page footer.
pub const ThemeFooterLink = struct {
    /// The name of the websites that display in the catalog page footer.
    display_name: ?[]const u8,

    /// The URL of the websites that display in the catalog page footer.
    footer_link_url: ?[]const u8,

    pub const json_field_names = .{
        .display_name = "DisplayName",
        .footer_link_url = "FooterLinkURL",
    };
};
