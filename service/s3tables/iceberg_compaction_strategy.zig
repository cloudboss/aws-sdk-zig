pub const IcebergCompactionStrategy = enum {
    auto,
    binpack,
    sort,
    zorder,

    pub const json_field_names = .{
        .auto = "AUTO",
        .binpack = "BINPACK",
        .sort = "SORT",
        .zorder = "ZORDER",
    };
};
