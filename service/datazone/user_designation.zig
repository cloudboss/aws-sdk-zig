pub const UserDesignation = enum {
    project_owner,
    project_contributor,
    project_catalog_viewer,
    project_catalog_consumer,
    project_catalog_steward,

    pub const json_field_names = .{
        .project_owner = "PROJECT_OWNER",
        .project_contributor = "PROJECT_CONTRIBUTOR",
        .project_catalog_viewer = "PROJECT_CATALOG_VIEWER",
        .project_catalog_consumer = "PROJECT_CATALOG_CONSUMER",
        .project_catalog_steward = "PROJECT_CATALOG_STEWARD",
    };
};
