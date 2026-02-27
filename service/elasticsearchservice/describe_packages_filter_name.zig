pub const DescribePackagesFilterName = enum {
    package_id,
    package_name,
    package_status,

    pub const json_field_names = .{
        .package_id = "PackageID",
        .package_name = "PackageName",
        .package_status = "PackageStatus",
    };
};
