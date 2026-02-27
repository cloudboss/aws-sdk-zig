pub const DatabaseEngineType = enum {
    rds_aurora_mysql,
    rds_aurora_postgresql,
    rds_mysql,
    rds_postgresql,

    pub const json_field_names = .{
        .rds_aurora_mysql = "RDS_AURORA_MYSQL",
        .rds_aurora_postgresql = "RDS_AURORA_POSTGRESQL",
        .rds_mysql = "RDS_MYSQL",
        .rds_postgresql = "RDS_POSTGRESQL",
    };
};
