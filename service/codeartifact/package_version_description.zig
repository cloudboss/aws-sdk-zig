const PackageFormat = @import("package_format.zig").PackageFormat;
const LicenseInfo = @import("license_info.zig").LicenseInfo;
const PackageVersionOrigin = @import("package_version_origin.zig").PackageVersionOrigin;
const PackageVersionStatus = @import("package_version_status.zig").PackageVersionStatus;

/// Details about a package version.
pub const PackageVersionDescription = struct {
    /// The name of the package that is displayed. The `displayName` varies
    /// depending
    /// on the package version's format. For example, if an npm package is named
    /// `ui`,
    /// is in the namespace `vue`, and has the format `npm`, then
    /// the `displayName` is `@vue/ui`.
    display_name: ?[]const u8 = null,

    /// The format of the package version.
    format: ?PackageFormat = null,

    /// The homepage associated with the package.
    home_page: ?[]const u8 = null,

    /// Information about licenses associated with the package version.
    licenses: ?[]const LicenseInfo = null,

    /// The namespace of the package version. The package component that specifies
    /// its
    /// namespace depends on its type. For example:
    ///
    /// * The namespace of a Maven package version is its `groupId`.
    ///
    /// * The namespace of an npm or Swift package version is its `scope`.
    ///
    /// * The namespace of a generic package is its `namespace`.
    ///
    /// * Python, NuGet, Ruby, and Cargo package versions do not contain a
    ///   corresponding component, package versions
    /// of those formats do not have a namespace.
    namespace: ?[]const u8 = null,

    /// A
    /// [PackageVersionOrigin](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_PackageVersionOrigin.html) object that contains
    /// information about how the package version was added to the repository.
    origin: ?PackageVersionOrigin = null,

    /// The name of the requested package.
    package_name: ?[]const u8 = null,

    /// A timestamp that contains the date and time the package version was
    /// published.
    published_time: ?i64 = null,

    /// The revision of the package version.
    revision: ?[]const u8 = null,

    /// The repository for the source code in the package version, or the source
    /// code used to build it.
    source_code_repository: ?[]const u8 = null,

    /// A string that contains the status of the package version.
    status: ?PackageVersionStatus = null,

    /// A summary of the package version. The summary is extracted from the package.
    /// The information in and
    /// detail level of the summary depends on the package version's format.
    summary: ?[]const u8 = null,

    /// The version of the package.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .display_name = "displayName",
        .format = "format",
        .home_page = "homePage",
        .licenses = "licenses",
        .namespace = "namespace",
        .origin = "origin",
        .package_name = "packageName",
        .published_time = "publishedTime",
        .revision = "revision",
        .source_code_repository = "sourceCodeRepository",
        .status = "status",
        .summary = "summary",
        .version = "version",
    };
};
