pub const FeatureType = enum {
    tables,
    forms,
    queries,
    signatures,
    layout,

    pub const json_field_names = .{
        .tables = "TABLES",
        .forms = "FORMS",
        .queries = "QUERIES",
        .signatures = "SIGNATURES",
        .layout = "LAYOUT",
    };
};
