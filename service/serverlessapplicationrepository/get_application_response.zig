const Version = @import("version.zig").Version;

pub const GetApplicationResponse = struct {
    /// The application Amazon Resource Name (ARN).
    application_id: ?[]const u8,

    /// The name of the author publishing the app.
    ///
    /// Minimum length=1. Maximum length=127.
    ///
    /// Pattern "^[a-z0-9](([a-z0-9]|-(?!-))*[a-z0-9])?$";
    author: ?[]const u8,

    /// The date and time this resource was created.
    creation_time: ?[]const u8,

    /// The description of the application.
    ///
    /// Minimum length=1. Maximum length=256
    description: ?[]const u8,

    /// A URL with more information about the application, for example the location
    /// of your GitHub repository for the application.
    home_page_url: ?[]const u8,

    /// Whether the author of this application has been verified. This means means
    /// that AWS has made a good faith review, as a reasonable and prudent service
    /// provider, of the information provided by the requester and has confirmed
    /// that the requester's identity is as claimed.
    is_verified_author: ?bool,

    /// Labels to improve discovery of apps in search results.
    ///
    /// Minimum length=1. Maximum length=127. Maximum number of labels: 10
    ///
    /// Pattern: "^[a-zA-Z0-9+\\-_:\\/@]+$";
    labels: ?[]const []const u8,

    /// A link to a license file of the app that matches the spdxLicenseID value of
    /// your application.
    ///
    /// Maximum size 5 MB
    license_url: ?[]const u8,

    /// The name of the application.
    ///
    /// Minimum length=1. Maximum length=140
    ///
    /// Pattern: "[a-zA-Z0-9\\-]+";
    name: ?[]const u8,

    /// A link to the readme file in Markdown language that contains a more detailed
    /// description of the application and how it works.
    ///
    /// Maximum size 5 MB
    readme_url: ?[]const u8,

    /// A valid identifier from https://spdx.org/licenses/.
    spdx_license_id: ?[]const u8,

    /// The URL to the public profile of a verified author. This URL is submitted by
    /// the author.
    verified_author_url: ?[]const u8,

    /// Version information about the application.
    version: ?Version,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .author = "Author",
        .creation_time = "CreationTime",
        .description = "Description",
        .home_page_url = "HomePageUrl",
        .is_verified_author = "IsVerifiedAuthor",
        .labels = "Labels",
        .license_url = "LicenseUrl",
        .name = "Name",
        .readme_url = "ReadmeUrl",
        .spdx_license_id = "SpdxLicenseId",
        .verified_author_url = "VerifiedAuthorUrl",
        .version = "Version",
    };
};
