pub const DataSetImportMode = enum {
    spice,
    direct_query,

    pub const json_field_names = .{
        .spice = "SPICE",
        .direct_query = "DIRECT_QUERY",
    };
};
