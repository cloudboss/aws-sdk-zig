pub const PackageVersionStatus = enum {
    published,
    unfinished,
    unlisted,
    archived,
    disposed,
    deleted,

    pub const json_field_names = .{
        .published = "PUBLISHED",
        .unfinished = "UNFINISHED",
        .unlisted = "UNLISTED",
        .archived = "ARCHIVED",
        .disposed = "DISPOSED",
        .deleted = "DELETED",
    };
};
