const PackageVersionStatus = @import("package_version_status.zig").PackageVersionStatus;

/// A summary of information about a package version.
pub const PackageVersionSummary = struct {
    /// The date that the package version was created.
    creation_date: ?i64 = null,

    /// The date that the package version was last updated.
    last_modified_date: ?i64 = null,

    /// The name of the associated software package.
    package_name: ?[]const u8 = null,

    /// The status of the package version. For more information, see [Package
    /// version
    /// lifecycle](https://docs.aws.amazon.com/iot/latest/developerguide/preparing-to-use-software-package-catalog.html#package-version-lifecycle).
    status: ?PackageVersionStatus = null,

    /// The name of the target package version.
    version_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_date = "creationDate",
        .last_modified_date = "lastModifiedDate",
        .package_name = "packageName",
        .status = "status",
        .version_name = "versionName",
    };
};
