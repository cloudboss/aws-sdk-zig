pub const ResourceType = enum {
    domain,
    repository,
    package,
    package_version,
    asset,

    pub const json_field_names = .{
        .domain = "DOMAIN",
        .repository = "REPOSITORY",
        .package = "PACKAGE",
        .package_version = "PACKAGE_VERSION",
        .asset = "ASSET",
    };
};
