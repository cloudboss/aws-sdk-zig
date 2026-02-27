pub const DescribePackagesFilterName = enum {
    package_id,
    package_name,
    package_status,
    package_type,
    engine_version,
    package_owner,

    pub const json_field_names = .{
        .package_id = "PackageID",
        .package_name = "PackageName",
        .package_status = "PackageStatus",
        .package_type = "PackageType",
        .engine_version = "EngineVersion",
        .package_owner = "PackageOwner",
    };
};
