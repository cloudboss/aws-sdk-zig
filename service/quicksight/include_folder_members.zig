pub const IncludeFolderMembers = enum {
    recurse,
    one_level,
    none,

    pub const json_field_names = .{
        .recurse = "RECURSE",
        .one_level = "ONE_LEVEL",
        .none = "NONE",
    };
};
