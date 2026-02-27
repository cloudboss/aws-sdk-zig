pub const PackageImportJobType = enum {
    node_package_version,
    marketplace_node_package_version,

    pub const json_field_names = .{
        .node_package_version = "NODE_PACKAGE_VERSION",
        .marketplace_node_package_version = "MARKETPLACE_NODE_PACKAGE_VERSION",
    };
};
