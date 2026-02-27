pub const UnionType = enum {
    all,
    distinct,

    pub const json_field_names = .{
        .all = "ALL",
        .distinct = "DISTINCT",
    };
};
