/// A structure that contains the customization fields for the web app. You can
/// provide a title, logo, and icon to customize the appearance of your web app.
pub const DescribedWebAppCustomization = struct {
    /// Returns the Amazon Resource Name (ARN) for the web app.
    arn: []const u8,

    /// Returns an icon file data string (in base64 encoding).
    favicon_file: ?[]const u8 = null,

    /// Returns a logo file data string (in base64 encoding).
    logo_file: ?[]const u8 = null,

    /// Returns the page title that you defined for your web app.
    title: ?[]const u8 = null,

    /// Returns the unique identifier for your web app.
    web_app_id: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .favicon_file = "FaviconFile",
        .logo_file = "LogoFile",
        .title = "Title",
        .web_app_id = "WebAppId",
    };
};
