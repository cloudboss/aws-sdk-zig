/// Summary of details about the application.
pub const ApplicationSummary = struct {
    /// The application Amazon Resource Name (ARN).
    application_id: []const u8,

    /// The name of the author publishing the app.
    ///
    /// Minimum length=1. Maximum length=127.
    ///
    /// Pattern "^[a-z0-9](([a-z0-9]|-(?!-))*[a-z0-9])?$";
    author: []const u8,

    /// The date and time this resource was created.
    creation_time: ?[]const u8 = null,

    /// The description of the application.
    ///
    /// Minimum length=1. Maximum length=256
    description: []const u8,

    /// A URL with more information about the application, for example the location
    /// of your GitHub repository for the application.
    home_page_url: ?[]const u8 = null,

    /// Labels to improve discovery of apps in search results.
    ///
    /// Minimum length=1. Maximum length=127. Maximum number of labels: 10
    ///
    /// Pattern: "^[a-zA-Z0-9+\\-_:\\/@]+$";
    labels: ?[]const []const u8 = null,

    /// The name of the application.
    ///
    /// Minimum length=1. Maximum length=140
    ///
    /// Pattern: "[a-zA-Z0-9\\-]+";
    name: []const u8,

    /// A valid identifier from
    /// [https://spdx.org/licenses/](https://spdx.org/licenses/).
    spdx_license_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .author = "Author",
        .creation_time = "CreationTime",
        .description = "Description",
        .home_page_url = "HomePageUrl",
        .labels = "Labels",
        .name = "Name",
        .spdx_license_id = "SpdxLicenseId",
    };
};
