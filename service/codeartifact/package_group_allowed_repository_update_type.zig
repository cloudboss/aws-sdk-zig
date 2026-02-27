pub const PackageGroupAllowedRepositoryUpdateType = enum {
    added,
    removed,

    pub const json_field_names = .{
        .added = "ADDED",
        .removed = "REMOVED",
    };
};
