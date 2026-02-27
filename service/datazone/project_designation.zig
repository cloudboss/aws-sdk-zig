pub const ProjectDesignation = enum {
    owner,
    contributor,
    project_catalog_steward,

    pub const json_field_names = .{
        .owner = "OWNER",
        .contributor = "CONTRIBUTOR",
        .project_catalog_steward = "PROJECT_CATALOG_STEWARD",
    };
};
