pub const PackageGroupOriginRestrictionMode = enum {
    allow,
    allow_specific_repositories,
    block,
    inherit,

    pub const json_field_names = .{
        .allow = "ALLOW",
        .allow_specific_repositories = "ALLOW_SPECIFIC_REPOSITORIES",
        .block = "BLOCK",
        .inherit = "INHERIT",
    };
};
