pub const ConfigurationSource = enum {
    catalog,
    table,

    pub const json_field_names = .{
        .catalog = "CATALOG",
        .table = "TABLE",
    };
};
