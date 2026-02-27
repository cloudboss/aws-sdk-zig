pub const CompactionStrategy = enum {
    binpack,
    sort,
    zorder,

    pub const json_field_names = .{
        .binpack = "BINPACK",
        .sort = "SORT",
        .zorder = "ZORDER",
    };
};
