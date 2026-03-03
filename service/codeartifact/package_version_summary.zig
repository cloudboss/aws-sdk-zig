const PackageVersionOrigin = @import("package_version_origin.zig").PackageVersionOrigin;
const PackageVersionStatus = @import("package_version_status.zig").PackageVersionStatus;

/// Details about a package version, including its status, version, and
/// revision. The
/// [ListPackageVersions](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_ListPackageVersions.html)
/// operation returns a list of `PackageVersionSummary` objects.
pub const PackageVersionSummary = struct {
    /// A
    /// [PackageVersionOrigin](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_PackageVersionOrigin.html) object that contains information
    /// about how the package version was added to the repository.
    origin: ?PackageVersionOrigin = null,

    /// The revision associated with a package version.
    revision: ?[]const u8 = null,

    /// A string that contains the status of the package version. It can be one of
    /// the following:
    status: PackageVersionStatus,

    /// Information about a package version.
    version: []const u8,

    pub const json_field_names = .{
        .origin = "origin",
        .revision = "revision",
        .status = "status",
        .version = "version",
    };
};
