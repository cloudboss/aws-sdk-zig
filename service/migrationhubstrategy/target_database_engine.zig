pub const TargetDatabaseEngine = enum {
    none_specified,
    amazon_aurora,
    aws_postgresql,
    mysql,
    microsoft_sql_server,
    oracle_database,
    maria_db,
    sap,
    db2_luw,
    mongo_db,

    pub const json_field_names = .{
        .none_specified = "NONE_SPECIFIED",
        .amazon_aurora = "AMAZON_AURORA",
        .aws_postgresql = "AWS_POSTGRESQL",
        .mysql = "MYSQL",
        .microsoft_sql_server = "MICROSOFT_SQL_SERVER",
        .oracle_database = "ORACLE_DATABASE",
        .maria_db = "MARIA_DB",
        .sap = "SAP",
        .db2_luw = "DB2_LUW",
        .mongo_db = "MONGO_DB",
    };
};
