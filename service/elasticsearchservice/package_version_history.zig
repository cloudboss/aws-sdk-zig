/// Details of a package version.
pub const PackageVersionHistory = struct {
    /// A message associated with the version.
    commit_message: ?[]const u8 = null,

    /// Timestamp which tells creation time of the package version.
    created_at: ?i64 = null,

    /// Version of the package.
    package_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .commit_message = "CommitMessage",
        .created_at = "CreatedAt",
        .package_version = "PackageVersion",
    };
};
