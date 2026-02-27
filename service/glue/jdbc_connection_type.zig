pub const JDBCConnectionType = enum {
    sqlserver,
    mysql,
    oracle,
    postgresql,
    redshift,

    pub const json_field_names = .{
        .sqlserver = "sqlserver",
        .mysql = "mysql",
        .oracle = "oracle",
        .postgresql = "postgresql",
        .redshift = "redshift",
    };
};
