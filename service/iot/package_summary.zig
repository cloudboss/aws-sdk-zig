/// A summary of information about a software package.
pub const PackageSummary = struct {
    /// The date that the package was created.
    creation_date: ?i64,

    /// The name of the default package version.
    default_version_name: ?[]const u8,

    /// The date that the package was last updated.
    last_modified_date: ?i64,

    /// The name for the target software package.
    package_name: ?[]const u8,

    pub const json_field_names = .{
        .creation_date = "creationDate",
        .default_version_name = "defaultVersionName",
        .last_modified_date = "lastModifiedDate",
        .package_name = "packageName",
    };
};
