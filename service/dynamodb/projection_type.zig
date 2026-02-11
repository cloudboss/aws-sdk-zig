pub const ProjectionType = enum {
    all,
    keys_only,
    include,

    pub const json_field_names = .{
        .all = "ALL",
        .keys_only = "KEYS_ONLY",
        .include = "INCLUDE",
    };
};
