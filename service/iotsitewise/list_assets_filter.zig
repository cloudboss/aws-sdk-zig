pub const ListAssetsFilter = enum {
    all,
    top_level,

    pub const json_field_names = .{
        .all = "ALL",
        .top_level = "TOP_LEVEL",
    };
};
