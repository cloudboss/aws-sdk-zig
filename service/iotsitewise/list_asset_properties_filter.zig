pub const ListAssetPropertiesFilter = enum {
    all,
    base,

    pub const json_field_names = .{
        .all = "ALL",
        .base = "BASE",
    };
};
