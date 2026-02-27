pub const TablePreparationMode = enum {
    do_nothing,
    truncate,
    drop_tables_on_target,

    pub const json_field_names = .{
        .do_nothing = "DO_NOTHING",
        .truncate = "TRUNCATE",
        .drop_tables_on_target = "DROP_TABLES_ON_TARGET",
    };
};
