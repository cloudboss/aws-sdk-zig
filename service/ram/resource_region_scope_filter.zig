pub const ResourceRegionScopeFilter = enum {
    all,
    regional,
    global,

    pub const json_field_names = .{
        .all = "ALL",
        .regional = "REGIONAL",
        .global = "GLOBAL",
    };
};
