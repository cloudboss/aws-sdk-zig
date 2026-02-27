pub const LensStatus = enum {
    current,
    not_current,
    deprecated,
    deleted,
    unshared,

    pub const json_field_names = .{
        .current = "CURRENT",
        .not_current = "NOT_CURRENT",
        .deprecated = "DEPRECATED",
        .deleted = "DELETED",
        .unshared = "UNSHARED",
    };
};
