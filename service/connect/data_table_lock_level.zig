pub const DataTableLockLevel = enum {
    none,
    data_table,
    primary_value,
    attribute,
    value,

    pub const json_field_names = .{
        .none = "NONE",
        .data_table = "DATA_TABLE",
        .primary_value = "PRIMARY_VALUE",
        .attribute = "ATTRIBUTE",
        .value = "VALUE",
    };
};
