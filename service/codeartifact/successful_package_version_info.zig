const PackageVersionStatus = @import("package_version_status.zig").PackageVersionStatus;

/// Contains the revision and status of a package version.
pub const SuccessfulPackageVersionInfo = struct {
    /// The revision of a package version.
    revision: ?[]const u8,

    /// The status of a package version.
    status: ?PackageVersionStatus,

    pub const json_field_names = .{
        .revision = "revision",
        .status = "status",
    };
};
