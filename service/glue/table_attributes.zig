pub const TableAttributes = enum {
    name,
    table_type,

    pub const json_field_names = .{
        .name = "NAME",
        .table_type = "TABLE_TYPE",
    };
};
