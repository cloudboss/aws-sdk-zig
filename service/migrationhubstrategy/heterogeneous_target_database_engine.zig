const std = @import("std");

pub const HeterogeneousTargetDatabaseEngine = enum {
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
        .none_specified = "None specified",
        .amazon_aurora = "Amazon Aurora",
        .aws_postgresql = "AWS PostgreSQL",
        .mysql = "MySQL",
        .microsoft_sql_server = "Microsoft SQL Server",
        .oracle_database = "Oracle Database",
        .maria_db = "MariaDB",
        .sap = "SAP",
        .db2_luw = "Db2 LUW",
        .mongo_db = "MongoDB",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none_specified => "None specified",
            .amazon_aurora => "Amazon Aurora",
            .aws_postgresql => "AWS PostgreSQL",
            .mysql => "MySQL",
            .microsoft_sql_server => "Microsoft SQL Server",
            .oracle_database => "Oracle Database",
            .maria_db => "MariaDB",
            .sap => "SAP",
            .db2_luw => "Db2 LUW",
            .mongo_db => "MongoDB",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
