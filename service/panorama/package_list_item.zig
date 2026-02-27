const aws = @import("aws");

/// A package summary.
pub const PackageListItem = struct {
    /// The package's ARN.
    arn: ?[]const u8,

    /// When the package was created.
    created_time: ?i64,

    /// The package's ID.
    package_id: ?[]const u8,

    /// The package's name.
    package_name: ?[]const u8,

    /// The package's tags.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_time = "CreatedTime",
        .package_id = "PackageId",
        .package_name = "PackageName",
        .tags = "Tags",
    };
};
