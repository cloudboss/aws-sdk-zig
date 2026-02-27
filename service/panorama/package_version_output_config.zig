/// A package version output configuration.
pub const PackageVersionOutputConfig = struct {
    /// Indicates that the version is recommended for all users.
    mark_latest: bool = false,

    /// The output's package name.
    package_name: []const u8,

    /// The output's package version.
    package_version: []const u8,

    pub const json_field_names = .{
        .mark_latest = "MarkLatest",
        .package_name = "PackageName",
        .package_version = "PackageVersion",
    };
};
