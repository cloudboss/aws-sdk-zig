pub const DatabaseType = enum {
    my_sql,
    postgre_sql,

    pub const json_field_names = .{
        .my_sql = "MySQL",
        .postgre_sql = "PostgreSQL",
    };
};
