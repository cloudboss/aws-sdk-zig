pub const Permission = enum {
    all,
    select,
    alter,
    drop,
    delete,
    insert,
    create_database,
    create_table,
    data_location_access,

    pub const json_field_names = .{
        .all = "ALL",
        .select = "SELECT",
        .alter = "ALTER",
        .drop = "DROP",
        .delete = "DELETE",
        .insert = "INSERT",
        .create_database = "CREATE_DATABASE",
        .create_table = "CREATE_TABLE",
        .data_location_access = "DATA_LOCATION_ACCESS",
    };
};
