pub const IsolineEngineType = enum {
    electric,
    internal_combustion,
    plugin_hybrid,

    pub const json_field_names = .{
        .electric = "ELECTRIC",
        .internal_combustion = "INTERNAL_COMBUSTION",
        .plugin_hybrid = "PLUGIN_HYBRID",
    };
};
