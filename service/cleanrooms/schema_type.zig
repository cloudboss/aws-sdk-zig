pub const SchemaType = enum {
    table,
    id_mapping_table,

    pub const json_field_names = .{
        .table = "TABLE",
        .id_mapping_table = "ID_MAPPING_TABLE",
    };
};
